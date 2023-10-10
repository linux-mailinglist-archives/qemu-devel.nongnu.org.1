Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C887BFBDB
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:56:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCHG-0003vM-2Q; Tue, 10 Oct 2023 08:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqCGt-0003tH-Ao
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqCGr-0004u1-Ku
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696942532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gpymgPXWCh+y6wfW6Sl1S9h01qvW3nzOMQn/RxwFNA=;
 b=gsmKYZvTilMNfuB45UZqzYzUbY1BeKnyLymt70GMtvpg/6rH/Hfbj4dykI1W/v0zI4irRY
 8Pp3bmcjT3vwszdGz1uOYvc1E/g/p27HTZDZUHGdLE6IihNTUbGsygiQZox0eaxohnC/Pe
 JhR1xVU90j1HGgyDH63KQ60mFfyX4l8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-Ho0YaMuPN0eByg6dP-OvXQ-1; Tue, 10 Oct 2023 08:55:28 -0400
X-MC-Unique: Ho0YaMuPN0eByg6dP-OvXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BF80185A795;
 Tue, 10 Oct 2023 12:55:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DBC21C060DF;
 Tue, 10 Oct 2023 12:55:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E7BC21E6904; Tue, 10 Oct 2023 14:55:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  fei2.wu@intel.com,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v17 09/16] util/log: Add Error argument to
 qemu_str_to_log_mask
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-10-richard.henderson@linaro.org>
Date: Tue, 10 Oct 2023 14:55:27 +0200
In-Reply-To: <20231003183058.1639121-10-richard.henderson@linaro.org> (Richard
 Henderson's message of "Tue, 3 Oct 2023 11:30:51 -0700")
Message-ID: <87y1gamybk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Do not rely on return value of 0 to indicate error,
> pass along an Error pointer to be set.

Not wrong, but goes against error.h's recommendation

 * - Whenever practical, also return a value that indicates success /
 *   failure.  This can make the error checking more concise, and can
 *   avoid useless error object creation and destruction.  Note that
 *   we still have many functions returning void.  We recommend
 *   =E2=80=A2 bool-valued functions return true on success / false on fail=
ure,
 *   =E2=80=A2 pointer-valued functions return non-null / null pointer, and
 *   =E2=80=A2 integer-valued functions return non-negative / negative.

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/log.h | 2 +-
>  bsd-user/main.c    | 6 ++++--
>  linux-user/main.c  | 7 +++++--
>  monitor/hmp-cmds.c | 5 +++--
>  softmmu/vl.c       | 7 +++++--
>  util/log.c         | 5 +++--
>  6 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index df59bfabcd..9b92d2663e 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -87,7 +87,7 @@ bool qemu_set_log_filename(const char *filename, Error =
**errp);
>  bool qemu_set_log_filename_flags(const char *name, int flags, Error **er=
rp);
>  void qemu_set_dfilter_ranges(const char *ranges, Error **errp);
>  bool qemu_log_in_addr_range(uint64_t addr);
> -int qemu_str_to_log_mask(const char *str);
> +int qemu_str_to_log_mask(const char *str, Error **errp);
>=20=20
>  /* Print a usage message listing all the valid logging categories
>   * to the specified FILE*.
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 703f3e2c41..a981239a0b 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -411,8 +411,10 @@ int main(int argc, char **argv)
>      {
>          int mask =3D 0;
>          if (log_mask) {
> -            mask =3D qemu_str_to_log_mask(log_mask);
> -            if (!mask) {
> +            Error *err =3D NULL;
> +            mask =3D qemu_str_to_log_mask(log_mask, &err);
> +            if (err) {
> +                error_report_err(err);
>                  qemu_print_log_usage(stdout);
>                  exit(1);
>              }
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 0c23584a96..d0464736cc 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -264,8 +264,11 @@ static void handle_arg_help(const char *arg)
>=20=20
>  static void handle_arg_log(const char *arg)
>  {
> -    last_log_mask =3D qemu_str_to_log_mask(arg);
> -    if (!last_log_mask) {
> +    Error *err =3D NULL;
> +
> +    last_log_mask =3D qemu_str_to_log_mask(arg, &err);
> +    if (err) {
> +        error_report_err(err);
>          qemu_print_log_usage(stdout);
>          exit(EXIT_FAILURE);
>      }
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 6c559b48c8..c4bd97d467 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -291,8 +291,9 @@ void hmp_log(Monitor *mon, const QDict *qdict)
>      if (!strcmp(items, "none")) {
>          mask =3D 0;
>      } else {
> -        mask =3D qemu_str_to_log_mask(items);
> -        if (!mask) {
> +        mask =3D qemu_str_to_log_mask(items, &err);
> +        if (err) {
> +            error_free(err);
>              hmp_help_cmd(mon, "log");
>              return;
>          }
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 98e071e63b..02193696b9 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2486,8 +2486,11 @@ static void qemu_process_early_options(void)
>      {
>          int mask =3D 0;
>          if (log_mask) {
> -            mask =3D qemu_str_to_log_mask(log_mask);
> -            if (!mask) {
> +            Error *err =3D NULL;
> +
> +            mask =3D qemu_str_to_log_mask(log_mask, &err);
> +            if (err) {
> +                error_report_err(err);
>                  qemu_print_log_usage(stdout);
>                  exit(1);
>              }
> diff --git a/util/log.c b/util/log.c
> index def88a9402..b5f08db202 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -500,8 +500,8 @@ const QEMULogItem qemu_log_items[] =3D {
>      { 0, NULL, NULL },
>  };
>=20=20
> -/* takes a comma separated list of log masks. Return 0 if error. */
> -int qemu_str_to_log_mask(const char *str)
> +/* Takes a comma separated list of log masks. */
> +int qemu_str_to_log_mask(const char *str, Error **errp)
>  {
>      const QEMULogItem *item;
>      int mask =3D 0;
> @@ -524,6 +524,7 @@ int qemu_str_to_log_mask(const char *str)
       char **parts =3D g_strsplit(str, ",", 0);
       char **tmp;

When @parts is null or "", the loop runs zero times, and ...

       for (tmp =3D parts; tmp && *tmp; tmp++) {
           if (g_str_equal(*tmp, "all")) {
               for (item =3D qemu_log_items; item->mask !=3D 0; item++) {
                   mask |=3D item->mask;
               }
   #ifdef CONFIG_TRACE_LOG
           } else if (g_str_has_prefix(*tmp, "trace:") && (*tmp)[6] !=3D '\=
0') {
               trace_enable_events((*tmp) + 6);
               mask |=3D LOG_TRACE;
   #endif
           } else {
               for (item =3D qemu_log_items; item->mask !=3D 0; item++) {
                   if (g_str_equal(*tmp, item->name)) {
>                      goto found;
>                  }
>              }
> +            error_setg(errp, "Invalid -d option \"%s\"", *tmp);
>              goto error;
>          found:
>              mask |=3D item->mask;
           }
       }

... we end up here with mask zero and no error set.

       g_strfreev(parts);
       return mask;

Before the patch, this counted as error.  Afterwards, it doesn't.
Impact?  Worth mentioning in the commit message?

    error:
       g_strfreev(parts);
       return 0;

Returning -1 here would stick to error.h's recommendation.

   }


