Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEB377E2B6
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 15:37:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWGga-0002Wl-Km; Wed, 16 Aug 2023 09:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qWGgY-0002WK-Nb; Wed, 16 Aug 2023 09:35:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qWGgV-0008In-QV; Wed, 16 Aug 2023 09:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N7IH6mEsOvy2VLG9Qyii4i2cASuVnBafhXnuXTPV8G8=; b=vLoDow0YQ6IW+b4cpDHafrVIRv
 nVC7qNb87AhOdjIGG+FP07ipoXnBGH0KBAYerqzz/Lo6Mni6BGmOkDJPLkpbQkPy35oWtZiyntqTO
 JCeHZX4o8q0RT1Au+5vCX8hMiIbqEERQ3nn+a8czp+TVpMT1VpsFe9qeztEu9tbgJAHAMyFb5vxxi
 04mkjYdBpUFYb+NGxW7HH6EIMpcvoGo0jpyL/vDniVZ8Wirf9UX6KlWS/sCHTVqw5B1VChLkRMZnL
 9Y6NI9lDMwKG7sogw5m0l3/DG1SREeNR0lKh9ACjtXZaqEdueyT1djBYKB6AeSxwshoGBtgCOpjwn
 kS01t6BAI7vZUh9lWD67WYwqCi9/VEgNTlYvJHM16Him9oKljZUfCsLSKstAwe13OvNIfnhsjtgOT
 Dowti3rHV9ve6YYeuuJ8/2ittPZx+aC6O/yhPI1hH7IlAMAeTFz07QR0+YXfw7jMYRdz974OVyVoA
 7qDFjXw4P3zMez+xY2eL1t4gOz/e3wZeo1V9q/Yp6mg1TXnDNnqdxqXVKhR4homac/S1jNvbYOAEC
 W5nTyxHS50WccXn+pNXkjERDd1CPhP/p/I7ECciHgssyMzzamEQYaF6BbpIFFm1fimtPQj6LWDNCe
 PMuyi7xd89xanIEemvC8tYpoJ7wu62r54hzZzuf6o=;
Received: from host81-158-188-207.range81-158.btcentralplus.com
 ([81.158.188.207] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qWGfu-0002RS-Jr; Wed, 16 Aug 2023 14:35:06 +0100
Message-ID: <f92321f6-0d3c-f446-d4bb-1dc78ba2f766@ilande.co.uk>
Date: Wed, 16 Aug 2023 14:35:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Waldemar Brodkorb <wbx@openadk.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block <qemu-block@nongnu.org>
References: <ZNiKYwbkk5zwlLB5@waldemar-brodkorb.de>
 <389cfe6d-aade-f79a-b618-fb0e029fff5d@linaro.org>
 <ZNyzch8J7Pv0pDEo@waldemar-brodkorb.de>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <ZNyzch8J7Pv0pDEo@waldemar-brodkorb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.158.188.207
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: qemu-system-m68k: ../hw/scsi/scsi-disk.c:557: scsi_write_data:
 Assertion `r->req.aiocb == NULL' failed.
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 16/08/2023 12:30, Waldemar Brodkorb wrote:

> Hi,
> Philippe Mathieu-Daudé wrote,
> 
>> Hi Waldemar
>>
>> On 13/8/23 09:46, Waldemar Brodkorb wrote:
>>> Hi,
>>>
>>> I am using Qemu 8.0.3 and getting this error:
>>> qemu-system-m68k: ../hw/scsi/scsi-disk.c:557: scsi_write_data: Assertion `r->req.aiocb == NULL' failed.
>>>
>>> It happens f.e. when I extract the glibc source code inside Linux.
>>> Linux 6.1.44, glibc 2.38 is used for the Linux system.
>>> I am starting qemu this way:
>>> qemu-system-m68k -nographic -M q800 -kernel /home/wbx/openadk/firmware/qemu-m68k-q800_glibc_68040/qemu-m68k-q800-archive-kernel qemu-m68k.img
>>>
>>> What can I do about it? Why this is happening on "heavy" I/O usage?
>>
>> Cc'ing the qemu-block list.
>>
>> Do you mind filling a bug report at
>> https://gitlab.com/qemu-project/qemu/-/issues ?
> 
> Okay, see here:
> https://gitlab.com/qemu-project/qemu/-/issues/1831

Thanks for the bug report! I'm currently working on improving the ESP emulation, so I 
can add your test case to my current suite of test images. My guess is that the write 
interrupt isn't being delayed correctly and so the assert() triggers due to buffer 
underflow.

Please can you upload the binary images to the bug report to allow me to try and 
reproduce this issue? The ESP code tends to be timing sensitive across kernel 
versions and OSs, so without this it will be difficult to reproduce.


ATB,

Mark.


