Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BEAB40A6F
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Sep 2025 18:22:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utTkU-0002pS-4w; Tue, 02 Sep 2025 12:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org>)
 id 1utTjw-0002hX-Js; Tue, 02 Sep 2025 12:20:14 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org>)
 id 1utTjr-0005LQ-6u; Tue, 02 Sep 2025 12:20:11 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cGWDK4BL3z4w9x;
 Wed,  3 Sep 2025 02:20:01 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cGWDG1w62z4w9s;
 Wed,  3 Sep 2025 02:19:57 +1000 (AEST)
Message-ID: <fb2b7122-ca4e-4171-a969-67df71045ac3@kaod.org>
Date: Tue, 2 Sep 2025 18:19:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?SmFuIEzDvGJiZSI=?= <jlu@pengutronix.de>,
 Joel Stanley <joel@jms.id.au>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
 <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
 <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
 <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
 <4c039b3c-dc2c-4478-b1bb-90b925e56245@linaro.org>
 <c8e1a073-7702-4bad-b7f1-2b4f51da47f4@kaod.org>
 <03a51e36-9a15-4b49-a310-c36a4d0af360@linaro.org>
 <2abbaeda-f9dc-4045-a9f7-b2b48451255f@kaod.org>
 <42310bdb-4fad-4df2-b7ad-3ff3f863e248@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <42310bdb-4fad-4df2-b7ad-3ff3f863e248@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/2/25 18:14, Philippe Mathieu-Daudé wrote:
> On 2/9/25 18:00, Cédric Le Goater wrote:
>> On 9/2/25 17:55, Philippe Mathieu-Daudé wrote:
>>> On 2/9/25 17:47, Cédric Le Goater wrote:
>>>> On 9/2/25 17:45, Philippe Mathieu-Daudé wrote:
>>>>> On 2/9/25 17:43, Philippe Mathieu-Daudé wrote:
>>>>>> On 2/9/25 17:34, Jan Kiszka wrote:
>>>>>>> On 02.09.25 17:06, Philippe Mathieu-Daudé wrote:
>>>>>>>> On 1/9/25 07:56, Jan Kiszka wrote:
>>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>
>>>>>>>>> The power-of-2 rule applies to the user data area, not the complete
>>>>>>>>> block image. The latter can be concatenation of boot partition images
>>>>>>>>> and the user data.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>>> ---
>>>>>>>>>    hw/sd/sd.c | 2 +-
>>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>>>>>>> index 8c290595f0..16aee210b4 100644
>>>>>>>>> --- a/hw/sd/sd.c
>>>>>>>>> +++ b/hw/sd/sd.c
>>>>>>>>> @@ -2789,7 +2789,7 @@ static void sd_realize(DeviceState *dev, Error
>>>>>>>>> **errp)
>>>>>>>>>                return;
>>>>>>>>>            }
>>>>>>>>>    -        blk_size = blk_getlength(sd->blk);
>>>>>>>>> +        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
>>>>>>>>>            if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>>>>>>>                int64_t blk_size_aligned = pow2ceil(blk_size);
>>>>>>>>>                char *blk_size_str;
>>>>>>>>
>>>>>>>> This seems to break the tests/functional/arm/test_aspeed_rainier.py
>>>>>>>> test due to mmc-p10bmc-20240617.qcow2 size:
>>>>>>>>
>>>>>>>> Command: /builds/qemu-project/qemu/build/qemu-system-arm -display none -
>>>>>>>> vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -
>>>>>>>> machine rainier-bmc -chardev socket,id=console,fd=10 -serial
>>>>>>>> chardev:console -drive file=/builds/qemu-project/qemu/functional- cache/
>>>>>>>> download/
>>>>>>>> d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b,if=sd,id=sd2,index=2 -net nic -net user -snapshot
>>>>>>>> Output: qemu-system-arm: Invalid SD card size: 16 GiB
>>>>>>>> SD card size has to be a power of 2, e.g. 16 GiB.
>>>>>>>>
>>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/11217561316
>>>>>>>>
>>>>>>>
>>>>>>> Hmm, then the test was always wrong as well. I suspect the aspeed is
>>>>>>> enabling boot partitions by default, and the image was created to pass
>>>>>>> the wrong alignment check. Where / by whom is the image maintained?
>>>>>>
>>>>>> Cédric Le Goater (Cc'ed).
>>>>>>
>>>>>> The test comes from:
>>>>>> https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb- a85f-09964268533d@kaod.org/
>>>>>>
>>>>>> Maybe also relevant to your suspicion:
>>>>>> https://lore.kernel.org/qemu-devel/e401d119-402e-0edd- c2bf-28950ba48ccb@kaod.org/
> 
> [*]
> 
>>>>>
>>>>> Digging further:
>>>>> https://lore.kernel.org/qemu- devel/9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/
>>>>>
>>>>
>>>> yes commit c078298301a8 might have some impact there.
>>>
>>> With Jan patch, your script doesn't need anymore the
>>>
>>>    echo "Fixing size to keep qemu happy..."
>>>
>>> kludge.
>>
>> which script ?
> 
> The one you pasted in [*]:

ah. That's Joel's from years ago. The witherspoon-tacoma is a Frankenstein
lab board for BMC bringup. I think all the needed info is in the commit log.

Thanks,

C.




> 
> -- 
> #!/bin/sh
> 
> URLBASE=https://jenkins.openbmc.org/view/latest/job/latest-master/label=docker-builder,target=witherspoon-tacoma/lastSuccessfulBuild/artifact/openbmc/build/tmp/deploy/images/witherspoon-tacoma/
> 
> IMAGESIZE=128
> OUTFILE=mmc.img
> 
> FILES="u-boot.bin u-boot-spl.bin obmc-phosphor-image-witherspoon-tacoma.wic.xz"
> 
> for file in ${FILES}; do
> 
>      if test -f ${file}; then
>          echo "${file}: Already downloaded"
>      else
>          echo "${file}: Downloading"
>          wget -nv ${URLBASE}/${file}
>      fi
> done
> 
> echo
> 
> echo "Creating empty image..."
> dd status=none if=/dev/zero of=${OUTFILE} bs=1M count=${IMAGESIZE}
> echo "Adding SPL..."
> dd status=none if=u-boot-spl.bin of=${OUTFILE} conv=notrunc
> echo "Adding u-boot..."
> dd status=none if=u-boot.bin of=${OUTFILE} conv=notrunc bs=1K seek=64
> echo "Adding userdata..."
> unxz -c obmc-phosphor-image-witherspoon-tacoma.wic.xz | dd status=progress of=${OUTFILE} conv=notrunc bs=1M seek=2
> echo "Fixing size to keep qemu happy..."
> truncate --size 16G ${OUTFILE}
> 
> echo "Done!"
> echo
> echo " qemu-system-arm -M tacoma-bmc -nographic -drive file=mmc.img,if=sd,index=2,format=raw"
> ---


