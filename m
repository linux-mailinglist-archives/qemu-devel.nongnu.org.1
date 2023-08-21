Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7886782507
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 10:02:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzr5-0006n8-Q1; Mon, 21 Aug 2023 04:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qXzr2-0006lD-7R
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 04:01:40 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qXzqy-0003zK-N3
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 04:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=jnFdpoNDQlz6IgELDzeUSGqF7KpvO1p/79AFq+GeOE0=; b=Fblp1cDgoWWllu+BjJrHjBfLli
 wKzzIBp+T2x2Dx34jrtvwCpsZL0btTP7uVRXbpsni3eaX4joDnjPhCq4jNnuOkCey7qoUuIwF/M1+
 I5tzUM6d2tK1wweEqrbOB5zgNE+L1DksPRg5MP3Gz4yoRRjXCuFgcSaAE8kml8yev2A8hvo25Vu4a
 kjg5T/yqChEoOE/1FFUS7hlagwWVElDYLA/lJN681vtn+UnPYiB09l5tTFaJLpPoptm2thUwXAZkI
 RekZDxgEQPnjMZGJU/i1S1JcBGVbu/POhERHwFYw5lmJp3JcS3M0p8HkCFSHatKDzTYBdyOiMeaMn
 O4o6r/49PqjByzv5Y12+yHG14eH5rfz8oKkzG1sCh1ZZgzL5uL7jcXdp7Frf7gHJKFnd4L9FxwuLm
 it+Bct+4C1ZT0jDc0e39MVOdy9zTHGyezwYoLz1/O6EAddF0FS2k4RqhcoNOl7yxyXgYF0WWgikCk
 AEH5Lxu8NoXvn2kVOUxWBfWf40LX19AAifm5saerFO9x5xpVpybXbHJan5bi8O8Pi9rfCrIsehm/z
 /bX4RfCnZgc7iHfNkVsf2yrSaE1hjpAWUMCenCDfZvZh224kmmlutbIxi8wmSD2xhjoENL6Vb/aFM
 9nomZ6L5g+wSZaat6XKQEL1pHOQ4J3MwloOHGnDf0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] audio/jackaudio: Avoid dynamic stack allocation in
 qjack_client_init
Date: Mon, 21 Aug 2023 10:01:32 +0200
Message-ID: <3689052.BXi5odulOJ@silver>
In-Reply-To: <20230818155846.1651287-2-peter.maydell@linaro.org>
References: <20230818155846.1651287-1-peter.maydell@linaro.org>
 <20230818155846.1651287-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Friday, August 18, 2023 5:58:45 PM CEST Peter Maydell wrote:
> Avoid a dynamic stack allocation in qjack_client_init(), by using
> a g_autofree heap allocation instead.
> 
> (We stick with allocate + snprintf() because the JACK API requires
> the name to be no more than its maximum size, so g_strdup_printf()
> would require an extra truncation step.)
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).

Sounds good, what compiler flag will that be?

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  audio/jackaudio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 5bdf3d7a78d..7cb2a49f971 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -400,7 +400,8 @@ static void qjack_client_connect_ports(QJackClient *c)
>  static int qjack_client_init(QJackClient *c)
>  {
>      jack_status_t status;
> -    char client_name[jack_client_name_size()];
> +    int client_name_len = jack_client_name_size(); /* includes NUL */

I would add `const` here.

> +    g_autofree char *client_name = g_new(char, client_name_len);
>      jack_options_t options = JackNullOption;
>  
>      if (c->state == QJACK_STATE_RUNNING) {
> @@ -409,7 +410,7 @@ static int qjack_client_init(QJackClient *c)
>  
>      c->connect_ports = true;
>  
> -    snprintf(client_name, sizeof(client_name), "%s-%s",
> +    snprintf(client_name, client_name_len, "%s-%s",
>          c->out ? "out" : "in",
>          c->opt->client_name ? c->opt->client_name : audio_application_name());

Unrelated, but this could be shortened by Elvis operator BTW:

    c->opt->client_name ?: audio_application_name()

Anyway:

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Best regards,
Christian Schoenebeck



