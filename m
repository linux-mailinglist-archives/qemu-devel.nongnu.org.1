Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 206279745EC
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Sep 2024 00:25:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9IZ-0004Ea-R6; Tue, 10 Sep 2024 18:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1so9IV-0003yY-7G; Tue, 10 Sep 2024 18:25:19 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1so9IT-00007F-CA; Tue, 10 Sep 2024 18:25:18 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B88061F836;
 Tue, 10 Sep 2024 22:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726007113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ngJZupkt611k1HwvHZHIrGAiSEDttJWiwH4VezFYDA=;
 b=IsJPlDelGX+nr5/FOwAUoKaLDkVeGRuJsjO5Ttp4G9CVC8eAQ6FHB2Xq8OP01tyhxwVDav
 iE717wPn8F3aN4GfLXvPenoYL+iwTd4Ois6/1tyh0KpZFNFqpY71qwVM0Zvs9MwNUskY4G
 cCHTofFJ4qY03+SV7OnoAaZ4rE6z6sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726007113;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ngJZupkt611k1HwvHZHIrGAiSEDttJWiwH4VezFYDA=;
 b=+WN70kXvXhiKPcyECLNcD1EOXXM2KPPgNHW0tek0hOiIIoHIYJJEOGAY5gHwpFw6254f9c
 UPV9Pe4BS9VBkVBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726007113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ngJZupkt611k1HwvHZHIrGAiSEDttJWiwH4VezFYDA=;
 b=IsJPlDelGX+nr5/FOwAUoKaLDkVeGRuJsjO5Ttp4G9CVC8eAQ6FHB2Xq8OP01tyhxwVDav
 iE717wPn8F3aN4GfLXvPenoYL+iwTd4Ois6/1tyh0KpZFNFqpY71qwVM0Zvs9MwNUskY4G
 cCHTofFJ4qY03+SV7OnoAaZ4rE6z6sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726007113;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ngJZupkt611k1HwvHZHIrGAiSEDttJWiwH4VezFYDA=;
 b=+WN70kXvXhiKPcyECLNcD1EOXXM2KPPgNHW0tek0hOiIIoHIYJJEOGAY5gHwpFw6254f9c
 UPV9Pe4BS9VBkVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD737132CB;
 Tue, 10 Sep 2024 22:25:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9MvrNUjH4GbMOQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Sep 2024 22:25:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones"
 <rjones@redhat.com>, Joel Stanley <joel@jms.id.au>, Kevin Wolf
 <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Corey Minyard <minyard@acm.org>, Eric Farman
 <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Keith Busch
 <kbusch@kernel.org>, WANG Xuerui <git@xen0n.name>, Hyman Huang
 <yong.huang@smartx.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, qemu-riscv@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Jesper Devantier
 <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell
 <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard
 Henderson <richard.henderson@linaro.org>, Fam Zheng <fam@euphon.net>,
 qemu-s390x@nongnu.org, Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier
 <lvivier@redhat.com>, Rob Herring <robh@kernel.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org, "Maciej S. Szmigiero"
 <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org, Daniel Henrique
 Barboza <danielhb413@gmail.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Nina
 Schoetterl-Glausch
 <nsg@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Helge Deller
 <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>, Akihiko Odaki
 <akihiko.odaki@daynix.com>, Marcelo Tosatti <mtosatti@redhat.com>, David
 Gibson <david@gibson.dropbear.id.au>, Aurelien Jarno
 <aurelien@aurel32.net>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Yanan
 Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Klaus Jensen
 <its@irrelevant.dk>, Jean-Christophe Dubois <jcd@tribudubois.net>, Jason
 Wang <jasowang@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 08/39] migration: replace assert(0) with
 g_assert_not_reached()
In-Reply-To: <20240910221606.1817478-9-pierrick.bouvier@linaro.org>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-9-pierrick.bouvier@linaro.org>
Date: Tue, 10 Sep 2024 19:25:10 -0300
Message-ID: <87plpbqh89.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[intel.com,redhat.com,jms.id.au,nongnu.org,acm.org,linux.ibm.com,kernel.org,xen0n.name,smartx.com,linux.vnet.ibm.com,gmail.com,wdc.com,ericsson.com,dabbelt.com,defmacro.it,vivier.eu,linaro.org,vger.kernel.org,euphon.net,habkost.net,oracle.com,gmx.de,ventanamicro.com,daynix.com,gibson.dropbear.id.au,aurel32.net,linux.alibaba.com,huawei.com,irrelevant.dk,tribudubois.net];
 R_RATELIMIT(0.00)[to_ip_from(RL77w4mfbgbm4kw8fg6bqi7qkm)];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_GT_50(0.00)[64];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,linaro.org:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  migration/migration-hmp-cmds.c |  2 +-
>  migration/postcopy-ram.c       | 14 +++++++-------
>  migration/ram.c                |  6 +++---
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 7d608d26e19..e6e96aa6288 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -636,7 +636,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          visit_type_bool(v, param, &p->direct_io, &err);
>          break;
>      default:
> -        assert(0);
> +        g_assert_not_reached();
>      }
>  
>      if (err) {
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 1c374b7ea1e..f431bbc0d4f 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1411,40 +1411,40 @@ int postcopy_ram_incoming_init(MigrationIncomingState *mis)
>  
>  int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>  {
> -    assert(0);
> +    g_assert_not_reached();
>      return -1;
>  }
>  
>  int postcopy_ram_prepare_discard(MigrationIncomingState *mis)
>  {
> -    assert(0);
> +    g_assert_not_reached();
>      return -1;
>  }
>  
>  int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
>                                   uint64_t client_addr, uint64_t rb_offset)
>  {
> -    assert(0);
> +    g_assert_not_reached();
>      return -1;
>  }
>  
>  int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
>  {
> -    assert(0);
> +    g_assert_not_reached();
>      return -1;
>  }
>  
>  int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>                          RAMBlock *rb)
>  {
> -    assert(0);
> +    g_assert_not_reached();
>      return -1;
>  }
>  
>  int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>                          RAMBlock *rb)
>  {
> -    assert(0);
> +    g_assert_not_reached();
>      return -1;
>  }
>  
> @@ -1452,7 +1452,7 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
>                           uint64_t client_addr,
>                           RAMBlock *rb)
>  {
> -    assert(0);
> +    g_assert_not_reached();
>      return -1;
>  }
>  #endif
> diff --git a/migration/ram.c b/migration/ram.c
> index 67ca3d5d51a..0aa5d347439 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1765,19 +1765,19 @@ bool ram_write_tracking_available(void)
>  
>  bool ram_write_tracking_compatible(void)
>  {
> -    assert(0);
> +    g_assert_not_reached();
>      return false;
>  }
>  
>  int ram_write_tracking_start(void)
>  {
> -    assert(0);
> +    g_assert_not_reached();
>      return -1;
>  }
>  
>  void ram_write_tracking_stop(void)
>  {
> -    assert(0);
> +    g_assert_not_reached();
>  }
>  #endif /* defined(__linux__) */

Reviewed-by: Fabiano Rosas <farosas@suse.de>

