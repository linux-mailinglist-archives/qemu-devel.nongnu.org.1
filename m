Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 879BA814AF1
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 15:48:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE9T2-0004iU-8i; Fri, 15 Dec 2023 09:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rE9Sz-0004hy-5K
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 09:47:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rE9Sx-0005H8-AP
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 09:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702651621;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLUhWB/sN5MyI4nTfOKidTvS/BXLq0iibl/Vmt824Rc=;
 b=b51OXFZcnk09h1HZyYSWXP8EK2oJXlwENOmevPL9kWsJwGrvWnj9d1ZfSJwtAV1ierta7x
 eFX/13wsgnNL0xbON0UMaLCLTCaWcWZysObEjhie8gb5I2q077qkRLsb8tTsDGpufwml1w
 NkH85re0AUJgpTrDGUO8XrPOM4VJbL4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-EoJS4xrVOBiqhgH5XEzE4A-1; Fri, 15 Dec 2023 09:46:58 -0500
X-MC-Unique: EoJS4xrVOBiqhgH5XEzE4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D21D485A58A;
 Fri, 15 Dec 2023 14:46:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EFA33C25;
 Fri, 15 Dec 2023 14:46:56 +0000 (UTC)
Date: Fri, 15 Dec 2023 14:46:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/qtest/npcm7xx_pwm-test: Only do full testing in
 slow mode
Message-ID: <ZXxm3vY4jzzaago_@redhat.com>
References: <20231215143524.49241-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231215143524.49241-1-thuth@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Dec 15, 2023 at 03:35:24PM +0100, Thomas Huth wrote:
> The npcm7xx_pwm-test can take quite a while when running with
> --enable-debug on a loaded system. The tests here are quite
> repetitive - by default it should be fine if we only execute
> some of them and only execute all when running in slow testing mode.

Yep, I think this change is not altering the code coverage
in any noticable way.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/npcm7xx_pwm-test.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/tests/qtest/npcm7xx_pwm-test.c b/tests/qtest/npcm7xx_pwm-test.c
> index ea4ca1d106..b53a43c417 100644
> --- a/tests/qtest/npcm7xx_pwm-test.c
> +++ b/tests/qtest/npcm7xx_pwm-test.c
> @@ -606,6 +606,7 @@ static void test_toggle(gconstpointer test_data)
>      uint32_t ppr, csr, pcr, cnr, cmr;
>      int i, j, k, l;
>      uint64_t expected_freq, expected_duty;
> +    int cnr_step = g_test_quick() ? 2 : 1;
>  
>      mft_init(qts, td);
>  
> @@ -618,7 +619,7 @@ static void test_toggle(gconstpointer test_data)
>              csr = csr_list[j];
>              pwm_write_csr(qts, td, csr);
>  
> -            for (k = 0; k < ARRAY_SIZE(cnr_list); ++k) {
> +            for (k = 0; k < ARRAY_SIZE(cnr_list); k += cnr_step) {
>                  cnr = cnr_list[k];
>                  pwm_write_cnr(qts, td, cnr);
>  
> @@ -678,6 +679,7 @@ static void pwm_add_test(const char *name, const TestData* td,
>  int main(int argc, char **argv)
>  {
>      TestData test_data_list[ARRAY_SIZE(pwm_module_list) * ARRAY_SIZE(pwm_list)];
> +    int pwm_module_list_cnt = 1, pwm_list_cnt = 1;
>  
>      char *v_env = getenv("V");
>  
> @@ -687,8 +689,13 @@ int main(int argc, char **argv)
>  
>      g_test_init(&argc, &argv, NULL);
>  
> -    for (int i = 0; i < ARRAY_SIZE(pwm_module_list); ++i) {
> -        for (int j = 0; j < ARRAY_SIZE(pwm_list); ++j) {
> +    if (!g_test_quick()) {
> +        pwm_module_list_cnt = ARRAY_SIZE(pwm_module_list);
> +        pwm_list_cnt = ARRAY_SIZE(pwm_list);
> +    }
> +
> +    for (int i = 0; i < pwm_module_list_cnt; ++i) {
> +        for (int j = 0; j < pwm_list_cnt; ++j) {
>              TestData *td = &test_data_list[i * ARRAY_SIZE(pwm_list) + j];
>  
>              td->module = &pwm_module_list[i];
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


