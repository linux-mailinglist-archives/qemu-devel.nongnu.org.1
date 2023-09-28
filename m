Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E24197B11B4
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 06:48:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qliwJ-0001Kp-UI; Thu, 28 Sep 2023 00:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qliwH-0001KX-F5; Thu, 28 Sep 2023 00:47:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qliwF-0006On-Fm; Thu, 28 Sep 2023 00:47:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 42F9A25D2B;
 Thu, 28 Sep 2023 07:48:10 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B12AE2B3FF;
 Thu, 28 Sep 2023 07:47:35 +0300 (MSK)
Message-ID: <0c8f70af-90dc-cdd9-f0fd-746eb503368e@tls.msk.ru>
Date: Thu, 28 Sep 2023 07:47:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/4] migration/qmp: Fix crash on setting tls-authz with
 null
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-stable@nongnu.org
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-2-peterx@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230905162335.235619-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

05.09.2023 19:23, Peter Xu:
> QEMU will crash if anyone tries to set tls-authz (which is a type
> StrOrNull) with 'null' value.  Fix it in the easy way by converting it to
> qstring just like the other two tls parameters.

Ping?  Has this been forgotten?

Thanks,

/mjt

> Cc: qemu-stable@nongnu.org # v4.0+
> Fixes: d2f1d29b95 ("migration: add support for a "tls-authz" migration parameter")
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   migration/options.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 1d1e1321b0..6bbfd4853d 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1408,20 +1408,25 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>   {
>       MigrationParameters tmp;
>   
> -    /* TODO Rewrite "" to null instead */
> +    /* TODO Rewrite "" to null instead for all three tls_* parameters */
>       if (params->tls_creds
>           && params->tls_creds->type == QTYPE_QNULL) {
>           qobject_unref(params->tls_creds->u.n);
>           params->tls_creds->type = QTYPE_QSTRING;
>           params->tls_creds->u.s = strdup("");
>       }
> -    /* TODO Rewrite "" to null instead */
>       if (params->tls_hostname
>           && params->tls_hostname->type == QTYPE_QNULL) {
>           qobject_unref(params->tls_hostname->u.n);
>           params->tls_hostname->type = QTYPE_QSTRING;
>           params->tls_hostname->u.s = strdup("");
>       }
> +    if (params->tls_authz
> +        && params->tls_authz->type == QTYPE_QNULL) {
> +        qobject_unref(params->tls_authz->u.n);
> +        params->tls_authz->type = QTYPE_QSTRING;
> +        params->tls_authz->u.s = strdup("");
> +    }
>   
>       migrate_params_test_apply(params, &tmp);
>   


