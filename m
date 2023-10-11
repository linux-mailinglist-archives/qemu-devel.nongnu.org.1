Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C8F7C55E5
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:50:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZbj-00015G-EP; Wed, 11 Oct 2023 09:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqZbY-00014k-In; Wed, 11 Oct 2023 09:50:28 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqZbU-0003MT-6P; Wed, 11 Oct 2023 09:50:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 569F5748FF4;
 Wed, 11 Oct 2023 15:49:25 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1225D7456AA; Wed, 11 Oct 2023 15:49:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 10EAB745681;
 Wed, 11 Oct 2023 15:49:25 +0200 (CEST)
Date: Wed, 11 Oct 2023 15:49:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/2] hw/ppc/ppc440_uc: Remove dead l2sram_update_mappings()
In-Reply-To: <93e4c252-e0bc-6eb2-cb80-924617f44285@linaro.org>
Message-ID: <8fb10284-d795-5c58-c509-7f0c50d94ceb@eik.bme.hu>
References: <20231011124312.60476-1-philmd@linaro.org>
 <20231011124312.60476-3-philmd@linaro.org>
 <46e1397e-dc3b-c90c-8b1b-f5b62807d3c0@eik.bme.hu>
 <93e4c252-e0bc-6eb2-cb80-924617f44285@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-227732667-1697032165=:10652"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-227732667-1697032165=:10652
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 11 Oct 2023, Philippe Mathieu-Daudé wrote:
> Hi Zoltan,
>
> On 11/10/23 15:31, BALATON Zoltan wrote:
>> On Wed, 11 Oct 2023, Philippe Mathieu-Daudé wrote:
>>> Apparently l2sram_update_mappings() bit-rotted over time,
>>> when defining MAP_L2SRAM we get:
>>> 
>>>  hw/ppc/ppc440_uc.c:83:17: error: no member named 'isarc' in 'struct 
>>> ppc4xx_l2sram_t'
>>>      if (l2sram->isarc != isarc ||
>>>          ~~~~~~  ^
>>>  hw/ppc/ppc440_uc.c:84:18: error: no member named 'isacntl' in 'struct 
>>> ppc4xx_l2sram_t'
>>>          (l2sram->isacntl & 0x80000000) != (isacntl & 0x80000000)) {
>>>           ~~~~~~  ^
>>>  hw/ppc/ppc440_uc.c:85:21: error: no member named 'isacntl' in 'struct 
>>> ppc4xx_l2sram_t'
>>>          if (l2sram->isacntl & 0x80000000) {
>>>              ~~~~~~  ^
>>>  hw/ppc/ppc440_uc.c:88:50: error: no member named 'isarc_ram' in 'struct 
>>> ppc4xx_l2sram_t'
>>>                                          &l2sram->isarc_ram);
>>>                                           ~~~~~~  ^
>>>  hw/ppc/ppc440_uc.c:93:50: error: no member named 'isarc_ram' in 'struct 
>>> ppc4xx_l2sram_t'
>>>                                          &l2sram->isarc_ram);
>>>                                           ~~~~~~  ^
>>>  hw/ppc/ppc440_uc.c:96:17: error: no member named 'dsarc' in 'struct 
>>> ppc4xx_l2sram_t'
>>>      if (l2sram->dsarc != dsarc ||
>>>          ~~~~~~  ^
>>>  hw/ppc/ppc440_uc.c:97:18: error: no member named 'dsacntl' in 'struct 
>>> ppc4xx_l2sram_t'
>>>          (l2sram->dsacntl & 0x80000000) != (dsacntl & 0x80000000)) {
>>>           ~~~~~~  ^
>>>  hw/ppc/ppc440_uc.c:98:21: error: no member named 'dsacntl' in 'struct 
>>> ppc4xx_l2sram_t'
>>>          if (l2sram->dsacntl & 0x80000000) {
>>>              ~~~~~~  ^
>>>  hw/ppc/ppc440_uc.c:100:52: error: no member named 'dsarc' in 'struct 
>>> ppc4xx_l2sram_t'
>>>              if (!(isacntl & 0x80000000) || l2sram->dsarc != isarc) {
>>>                                             ~~~~~~  ^
>>>  hw/ppc/ppc440_uc.c:103:54: error: no member named 'dsarc_ram' in 'struct 
>>> ppc4xx_l2sram_t'
>>>                                              &l2sram->dsarc_ram);
>>>                                               ~~~~~~  ^
>>>  hw/ppc/ppc440_uc.c:111:54: error: no member named 'dsarc_ram' in 'struct 
>>> ppc4xx_l2sram_t'
>>>                                              &l2sram->dsarc_ram);
>>>                                               ~~~~~~  ^
>>> 
>>> Remove that dead code.
>
> I missed to remove:
>
> -- >8 --
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index 3a66b0c7f7..1312aa2080 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -154,7 +154,6 @@ static void dcr_write_l2sram(void *opaque, int dcrn, 
> uint32_t val)
>         /*l2sram->isram1[dcrn - DCR_L2CACHE_BASE] = val;*/
>         break;
>     }
> -    /*l2sram_update_mappings(l2sram, isarc, isacntl, dsarc, dsacntl);*/
> }

Well, all of this func does nothing and just here so accessing these DCRs 
won't crash but it already has a FIXME comment at the beginning noting 
that, so in that case it's probably OK to remove the unfinished func as we 
still have a reminder here. So then:

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> static void l2sram_reset(void *opaque)
> @@ -164,7 +163,6 @@ static void l2sram_reset(void *opaque)
>     memset(l2sram->l2cache, 0, sizeof(l2sram->l2cache));
>     l2sram->l2cache[DCR_L2CACHE_STAT - DCR_L2CACHE_BASE] = 0x80000000;
>     memset(l2sram->isram0, 0, sizeof(l2sram->isram0));
> -    /*l2sram_update_mappings(l2sram, isarc, isacntl, dsarc, dsacntl);*/
> }
> ---
>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> hw/ppc/ppc440_uc.c | 40 ----------------------------------------
>>> 1 file changed, 40 deletions(-)
>>> 
>>> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
>>> index 4181c843a8..643a79e330 100644
>>> --- a/hw/ppc/ppc440_uc.c
>>> +++ b/hw/ppc/ppc440_uc.c
>>> @@ -73,46 +73,6 @@ typedef struct ppc4xx_l2sram_t {
>>>     uint32_t isram0[11];
>>> } ppc4xx_l2sram_t;
>>> 
>>> -#ifdef MAP_L2SRAM
>>> -static void l2sram_update_mappings(ppc4xx_l2sram_t *l2sram,
>>> -                                   uint32_t isarc, uint32_t isacntl,
>>> -                                   uint32_t dsarc, uint32_t dsacntl)
>> 
>> If you remove this then nobody will remember this could be modelled or may 
>> be fixed so maybe leave it as a reminder for now.
>
> We can keep this code if someone fix it and enable it (convert the
> definition to a static boolean). Some APIs are being modified, we can
> not test modifications in such dead code. Even converting to a comment
> doesn't seem useful.
>
> Maybe you can add a comment "If you are interested in ..., see
> l2sram_update_mappings() draft implementation in
> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04261.html"?
>
>> Regards,
>> BALATON Zoltan
>
>
>
--3866299591-227732667-1697032165=:10652--

