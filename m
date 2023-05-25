Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7728710F42
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:14:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Cf1-0002jU-TN; Thu, 25 May 2023 11:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2Cf0-0002iu-2e
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2Cey-0004j0-Cc
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685027627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q/y6p/XuOKxUx5ZrLxhRXP9O8JrpmMUZWImuRoDrmNE=;
 b=YgVOfFtC8/jVKKzTTc9XbFDwFPeP+pnc5KsvO94xzEww+P3/PjOvPE7HvIkyd2LF3S/JO9
 s70XF44miUrBINNfOGRdbWi0H6EcWn/IXo00MsrRT3Blr5a5XzshwDJX8Uf2pad6r7mQGI
 7TQQh9rEXSSs/LTTDg+4f9nryPxTIy0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-XKVc6haQN-CrZzA0qBHJVw-1; Thu, 25 May 2023 11:13:45 -0400
X-MC-Unique: XKVc6haQN-CrZzA0qBHJVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3411738149A3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:13:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 138C07AF5
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:13:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0A99921E692E; Thu, 25 May 2023 17:13:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] monitor: add more *_locked() functions
References: <20230518101804.992085-1-pbonzini@redhat.com>
 <20230518101804.992085-4-pbonzini@redhat.com>
Date: Thu, 25 May 2023 17:13:44 +0200
In-Reply-To: <20230518101804.992085-4-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 18 May 2023 12:18:03 +0200")
Message-ID: <87y1lcmok7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Allow flushing and printing to the monitor while mon->mon_lock is
> held.  This will help cleaning up the locking of mon->mux_out and
> mon->suspend_cnt.

Actually, the patch adds just monitor_puts_locked().
monitor_flush_locked() it merely gives external linkage.  Suggest

  monitor: More *_locked() functions

  Being able to print to the monitor and flush while mon->mon_lock is
  held will help cleaning up the locking of mon->mux_out and
  mon->suspend_cnt in the next commit.  Give monitor_flush_locked()
  external linkage, and factor monitor_puts_locked() out of
  monitor_puts().
  
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/monitor/monitor.h |  3 +++
>  monitor/monitor.c         | 14 ++++++++------
>  2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 033390f69917..965f5d545003 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -40,6 +40,9 @@ void monitor_flush(Monitor *mon);
>  int monitor_set_cpu(Monitor *mon, int cpu_index);
>  int monitor_get_cpu_index(Monitor *mon);
>  
> +int monitor_puts_locked(Monitor *mon, const char *str);
> +void monitor_flush_locked(Monitor *mon);
> +
>  void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp);
>  
>  void monitor_read_command(MonitorHMP *mon, int show_prompt);
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 7080d2da8ec6..20e33e28d20d 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -154,8 +154,6 @@ static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
>      return !monitor_uses_readline(container_of(mon, MonitorHMP, common));
>  }
>  
> -static void monitor_flush_locked(Monitor *mon);
> -
>  static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
>                                    void *opaque)
>  {
> @@ -168,7 +166,7 @@ static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
>  }
>  
>  /* Caller must hold mon->mon_lock */
> -static void monitor_flush_locked(Monitor *mon)
> +void monitor_flush_locked(Monitor *mon)
>  {
>      int rc;
>      size_t len;
> @@ -207,12 +205,11 @@ void monitor_flush(Monitor *mon)
>  }
>  
>  /* flush at every end of line */
> -int monitor_puts(Monitor *mon, const char *str)
> +int monitor_puts_locked(Monitor *mon, const char *str)
>  {
>      int i;
>      char c;
>  
> -    qemu_mutex_lock(&mon->mon_lock);
>      for (i = 0; str[i]; i++) {
>          c = str[i];
>          if (c == '\n') {
> @@ -223,11 +220,16 @@ int monitor_puts(Monitor *mon, const char *str)
>              monitor_flush_locked(mon);
>          }
>      }
> -    qemu_mutex_unlock(&mon->mon_lock);
>  
>      return i;
>  }
>  
> +int monitor_puts(Monitor *mon, const char *str)
> +{
> +    QEMU_LOCK_GUARD(&mon->mon_lock);
> +    return monitor_puts_locked(mon, str);
> +}
> +
>  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
>  {
>      char *buf;

Prefereably with a clarified commit message
Reviewed-by: Markus Armbruster <armbru@redhat.com>


