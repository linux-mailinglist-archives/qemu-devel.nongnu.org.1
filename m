Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1707E483F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:29:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QoT-0008Q7-MD; Tue, 07 Nov 2023 13:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0QoQ-0008PL-Pu; Tue, 07 Nov 2023 13:28:30 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0QoP-0006gn-BN; Tue, 07 Nov 2023 13:28:30 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0FBA375A4BC;
 Tue,  7 Nov 2023 19:28:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0349275A4B9; Tue,  7 Nov 2023 19:28:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0170475A4B7;
 Tue,  7 Nov 2023 19:28:43 +0100 (CET)
Date: Tue, 7 Nov 2023 19:28:43 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH v8 2/3] hw/ppc: Add emulation of AmigaOne XE board
In-Reply-To: <CAFEAcA_fcfTcD_bbtgK8W2V65ks9wgChA0gnT=cHjb0fZ48HLQ@mail.gmail.com>
Message-ID: <a40d1036-7343-2e38-cd8f-478f3d5c607e@eik.bme.hu>
References: <9917e6e80f9fdab079d06130403aebc5a8544316.1698406922.git.balaton@eik.bme.hu>
 <63e5ae9ef7c919e7294bc656a009e5310e10d632.1699380861.git.balaton@eik.bme.hu>
 <CAFEAcA_fcfTcD_bbtgK8W2V65ks9wgChA0gnT=cHjb0fZ48HLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 7 Nov 2023, Peter Maydell wrote:
> On Tue, 7 Nov 2023 at 18:21, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> The AmigaOne is a rebranded MAI Teron board that uses U-Boot firmware
>> with patches to support AmigaOS and is very similar to pegasos2 so can
>> be easily emulated sharing most code with pegasos2. The reason to
>> emulate it is that AmigaOS comes in different versions for AmigaOne
>> and PegasosII which only have drivers for one machine and firmware so
>> these only run on the specific machine. Adding this board allows
>> another AmigaOS version to be used reusing already existing peagasos2
>> emulation. (The AmigaOne was the first of these boards so likely most
>> widespread which then inspired Pegasos that was later replaced with
>> PegasosII due to problems with Articia S, so these have a lot of
>> similarity. Pegasos mainly ran MorphOS while the PegasosII version of
>> AmigaOS was added later and therefore less common than the AmigaOne
>> version.)
>> +    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, fwname);
>> +    if (!filename) {
>> +        error_report("Could not find firmware '%s'", fwname);
>> +        /* qtest/test-hmp expects to be able to run the machine without -bios */
>> +        if (!qtest_enabled()) {
>> +            exit(1);
>> +        }
>
> You should put the error_report() line inside the if() as well,
> to stop the error line turning up in the logfiles/stdout. This
> is what we do for the various MIPS boards that ordinarily
> need a BIOS blob.

OK, I'll do a v9 then...

Regards,
BALATON Zoltan

