Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E670783638B
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 13:43:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRtcw-0007Yd-G6; Mon, 22 Jan 2024 07:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rRtct-0007Ul-GC
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 07:42:07 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rRtcq-0005iX-Hz
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 07:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Dzp0j8i6AyZE+zUe229Gp8wTN7qWEO5Ek6d/mLBMug=; b=sRcnuMInvF4vIIptfHGQWGm2WM
 aFGrv5LnKNfHTF6zG8v/uB9FAX0006cL9ZdHbxPpMAqhlUdRW/0Ea4OW18As1hVZuTyVqjA5QS48q
 O0CaE1K+dB0Y8HiPGV2Qj78tzbzQfLpk1lmh2M5U6fz5Ikq0+LAXQmK8ELyttMpTkEVHd4oV9fS2J
 p08YvdGdt2DO4x95iBq2djazoPRyG7MFA0k30ZRVTWZITubYkrBOv3mgTypgIr4f5/V0HkAa2qJt4
 mWa0X8z6W+hBrD4+exM2VX0Wcalqh4yjtYgbI5cZ6ThM2Qy2Nuv+axUmczLG+XLIc7ltOrpCI7kJz
 wOXjGskz1D2V1DxSqIeubfr+F7xpqk7sh7R5+fGXgSPtAsehQD8KqeFhcG5GiPWWCsTGOG7p2V2rS
 WF2Tw1wzkHE3s1c7xWKFrW/F2tWPgiPObCGn2B2pDAX7jUGMVd5TebclMnM17phTzIaBcxFJ5+3wC
 oJEK8lv1/Utsqcw48Y4IlGNwnMwZE6cJbb+NJ2SnO1hxPyi8qcEOm3aOwaxcSUZcxt7tdzJwJ5dPS
 3HxEZfMf8sExMJhhuzw1Zo30H3Tv/Wj2i1Y8A5aVTKtvBo5fztsgh+p/Vcqdz/Q5QpSlZ4wuFiyB8
 vuu5+SmmWXzwGuy5uNFhKgpLg7pOslQ6JPECMV/G8=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rRtc1-0008ce-MT; Mon, 22 Jan 2024 12:41:17 +0000
Message-ID: <dbb99894-29c3-4e78-af4c-0770014049ab@ilande.co.uk>
Date: Mon, 22 Jan 2024 12:41:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 00/88] esp: rework ESP emulation to use a SCSI phase-based
 state machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 12/01/2024 12:52, Mark Cave-Ayland wrote:

> The ESP SCSI chip fundamentally consists of a FIFO for transferring data to/from
> the SCSI bus along with a command sequencer which automates various processes such
> as selection, message/command transfer and data transfer. What makes this chip
> particularly interesting is that the FIFO is also used as a buffer for DMA transfers
> which makes it possible to mix and match DMA and non-DMA transfers when sending and
> receiving data to/from the SCSI bus.
> 
> Whilst the current ESP emulation works well for most cases, there are several
> problems that I've encountered whilst trying to debug various guest issues:
> 
> 
> 1) Multiple code paths for non-DMA, DMA and pDMA
> 
> Consider a SCSI request being submitted by the guest: if it is a DMA SCSI
> request then it takes one path through get_cmd(), and a different path through
> get_cmd() for pDMA. This then leads to the DMA code path being called for DMA
> and the pDMA codepath being called for each FIFO write. Finally once you add
> in the non-DMA path you end up with a total of 5 potential codepaths for any
> given SCSI request.
> 
> 2) Manual handling of STAT_TC flag
> 
> According to the datasheet the STAT_TC flag in ESP_RSTAT is set when the DMA
> transfer counter reaches zero. The current code handles this manually in
> multiple places, including where it shouldn't be necessary.
> 
> 3) Deferred interrupts are used only for reads and not writes
> 
> The ESP emulation currently makes use of a deferred interrupt when submitting
> read commands i.e. the interrupt flags are not updated immediately but when
> the QEMU SCSI layer indicates it is ready. This works well for reads, but isn't
> implemented for writes which can cause problems when the host is heavily loaded
> or a large SCSI write is requested.
> 
> 4) Padding of pDMA TI transfers to a minimum of 16 bytes
> 
> In order to allow Classic MacOS to boot successfully there is a workaround that
> pads all pDMA TI transfers to a minimum of 16 bytes (see commit 7aa6baee7c
> "esp: add support for unaligned accesses"). This feature is not documented and it
> turns out that this is a symptom of incorrect handling of transfer
> overflow/underflow conditions.
> 
> 5) Duplication of some non-DMA logic in esp_reg_read() and esp_reg_write()
> 
> When reading and writing to the FIFO there is some duplication of logic from
> esp_do_nodma() in esp_reg_read() and esp_reg_write(). This should be eliminated
> in favour of a single state machine for handling non-DMA FIFO accesses in a
> single place.
> 
> 
> The series here reworks the ESP emulation to use a SCSI phase-based state machine
> with just two paths: one for DMA/pDMA requests, and another for non-DMA requests.
> The pDMA callbacks are completely removed so that there is now only a single path
> for DMA requests. As part of this work the manual STAT_TC handling is removed, and a
> couple of bugs in the SCSI phase selection are fixed to allow proper transfer
> underflow/overflow detection and recovery.
> 
> I've tested the series with all of my available ESP images and compatibility is
> greatly improved with these changes: I believe that this series should also fix a
> few GitLab issues including https://gitlab.com/qemu-project/qemu/-/issues/1831,
> https://gitlab.com/qemu-project/qemu/-/issues/611 and
> https://gitlab.com/qemu-project/qemu/-/issues/1127. In addition it allows Aurelien's
> really old SPARC Linux images to boot once again, and also the NeXTCube machine can
> now boot, load its kernel from disk and start to execute it.
> 
> The series breaks down into the following approximate sections:
> 
>    - Patches 1-6 do some initial tidy-up for ESP select commands
> 
>    - Patches 7-16 implement consolidation of the STAT_TC flag handling
> 
>    - Patches 17-36 start to bring esp_do_dma() and do_pdma_dma() into line with each
>      other, removing unneeded hacks and fixing up end-of-phase logic
> 
>    - Patches 37-56 move the MESSAGE OUT and COMMAND phase processing to the new SCSI
>      phase-based state machine, allowing the removal of the pDMA-specific callbacks
> 
>    - Patches 57-62 tidy up the end of SCSI command logic and adds deferred interrupt
>      handling for the DATA IN phase to complement the existing DATA OUT phase
>      implementation
> 
>    - Patches 63-64 remove the ti_cmd field which is now no longer required
> 
>    - Patches 65-67 move the last bit of MESSAGE OUT and COMMAND phase processing to
>      the new SCSI phase-based state machine which allows get_cmd() to be removed
> 
>    - Patches 68-69 move the STATUS and MESSAGE IN phase processing to the new SCSI
>      phase-based state machine
> 
>    - Patches 70-72 fix the reset of the ESP_RINTR/ESP_STAT registers which allows the
>      TC underflow detection to work correctly
> 
>    - Patch 73 removes the restriction on FIFO read access if the DMA routines are not
>      defined (which also allows the NeXTCube to pass its self-test)
> 
>    - Patches 74-77 update the state machine to allow more combinations of mixed TI
>      and FIFO reads/writes exposed by my test images
> 
>    - Patches 78-88 are final tidy-ups and improvements, along with adding an
>      implementation of the "Transfer Pad" command
> 
> There is a migration break for the Q800 machine here as the series removes the pDMA
> subsection: this seems the safest option as it isn't possible to map the old pDMA
> callback enum directly to the new state machine. In theory there is a small window
> whereby the normal DMA state may miss setting data_ready correctly, but I haven't
> been able to recreate this during my tests.
> 
> 
> Notes for reviewers:
> 
> This series is not a particularly easy one to review without having good in-depth
> knowledge of the ESP device. The biggest issue I found is that due to the state
> machines used by the client upon receiving an interrupt, a change to a ESP register
> in one place can cause a completely unrelated error elsewhere.
> 
> A prime example of this is the consolidation of the STAT_TC flag: updating the
> emulated device to behave as described in the datasheet caused other failures until
> other fixes/updates could be made. This is why the work is done over 2 separate
> commits with a gap in-between to keep the series bisectible, clearly indicating how
> sensitive this series is to commit order.
> 
> In order to implement the changes I decided to focus on 3 main test images that should
> pass for each commit to keep the series bisectible:
> 
> 1) Modern Linux kernel with am53c974.c (hppa)
> 2) Modern Linux kernel with mac_esp.c (q800)
> 3) Classic MacOS 8.0
> 
> Other images may stop working during parts of the series, which sometimes is the
> only option as otherwise implementing a compatibility workaround would be
> prohibitively time-consuming or impossible at that point in the series. By the
> end of the series all of my test images work correctly, including a few extra that
> don't work with QEMU current git master.
> 
> Finally it is worth reiterating that in its current form this series fixes several
> significant bugs and improves the compatibility of the ESP emulation, and these changes
> make future fixes considerably easier compared with the existing implementation.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> 
> Mark Cave-Ayland (88):
>    esp: don't clear cmdfifo when esp_select() fails in get_cmd()
>    esp: move existing request cancel check into esp_select()
>    esp.c: add FIFO wraparound support to esp_fifo_pop_buf()
>    esp: remove FIFO clear from esp_select()
>    esp: move esp_select() to ESP selection commands from get_cmd()
>    esp: update esp_set_tc() to set STAT_TC flag
>    esp: start removal of manual STAT_TC setting when transfer counter
>      reaches zero
>    esp: move command execution logic to new esp_run_cmd() function
>    esp: update TC check logic in do_dma_pdma_cb() to check for TC == 0
>    esp: move buffer and TC logic into separate to/from device paths in
>      esp_do_dma()
>    esp.c: remove unused case from esp_pdma_read()
>    esp.c: don't accumulate directly into cmdfifo
>    esp.c: decrement the TC during MESSAGE OUT and COMMAND phases
>    esp.c: introduce esp_set_phase() helper function
>    esp.c: remove another set of manual STAT_TC updates
>    esp.c: remove MacOS TI workaround that pads FIFO transfers to
>      ESP_FIFO_SZ
>    esp.c: don't reset the TC and ESP_RSEQ state when executing a SCSI
>      command
>    esp.c: don't clear RFLAGS register when DMA is complete
>    esp: remove zero transfer size check from esp_do_dma()
>    esp.c: update condition for esp_dma_done() in esp_do_dma() from device
>      path
>    esp.c: update condition for esp_dma_done() in esp_do_dma() to device
>      path
>    esp.c: ensure that the PDMA callback is called for every device read
>    esp.c: don't immediately raise INTR_BS if SCSI data needed in
>      esp_do_dma()
>    esp.c: remove TC adjustment in esp_do_dma() from device path
>    esp.c: remove unaligned adjustment in do_dma_pdma_cb() to device path
>    esp.c: remove unneeded if() check in esp_transfer_data()
>    esp.c: update end of transfer logic at the end of esp_transfer_data()
>    esp.c: consolidate async_len and TC == 0 checks in do_dma_pdma_cb()
>      and esp_do_dma()
>    esp.c: fix premature end of phase logic esp_command_complete
>    esp.c: move TC and FIFO check logic into esp_dma_done()
>    esp.c: rename esp_dma_done() to esp_dma_ti_check()
>    esp.c: copy PDMA logic for transfers to device from do_dma_pdma_cb()
>      to esp_do_dma()
>    esp.c: copy logic for do_cmd transfers from do_dma_pdma_cb() to
>      esp_do_dma()
>    esp.c: update esp_do_dma() bypass if async_len is zero to include
>      non-zero transfer check
>    esp.c: move end of SCSI transfer check after TC adjustment in
>      do_dma_pdma_cb()
>    esp.c: remove s_without_satn_pdma_cb() PDMA callback
>    esp.c: introduce esp_get_phase() function
>    esp.c: convert esp_do_dma() to switch statement based upon SCSI phase
>    esp.c: convert do_dma_pdma_db() to switch statement based upon SCSI
>      phase
>    esp.c: convert esp_do_nodma() to switch statement based upon SCSI
>      phase
>    esp.c: convert esp_do_dma() do_cmd path to check for SCSI phase
>      instead
>    esp.c: convert do_dma_pdma_cb() do_cmd path to check for SCSI phase
>      instead
>    esp.c: convert esp_do_nodma() do_cmd path to check for SCSI phase
>      instead
>    esp.c: convert esp_reg_write() do_cmd path to check for SCSI phase
>      instead
>    esp.c: remove do_cmd from ESPState
>    esp.c: untangle MESSAGE OUT and COMMAND phase logic in esp_do_dma()
>    esp.c: untangle MESSAGE OUT and COMMAND phase logic in
>      do_dma_pdma_cb()
>    esp.c: untangle MESSAGE OUT and COMMAND phase logic in esp_do_nodma()
>    esp.c: move CMD_SELATN end of message phase detection to esp_do_dma()
>      and do_dma_pdma_cb()
>    esp.c: move CMD_TI end of message phase detection to esp_do_dma() and
>      do_dma_pdma_cb()
>    esp.c: don't use get_cmd() for CMD_SEL DMA commands
>    esp.c: move CMD_SELATNS end of command logic to esp_do_dma() and
>      do_dma_pdma_cb()
>    esp.c: replace do_dma_pdma_cb() with esp_do_dma()
>    esp.c: move CMD_ICCS command logic to esp_do_dma()
>    esp.c: always use esp_do_dma() in pdma_cb()
>    esp.c: remove unused PDMA callback implementation
>    esp.c: rename data_in_ready to to data_ready
>    esp.c: separate logic based upon ESP command in esp_command_complete()
>    esp.c: separate logic based upon ESP command in esp_transfer_data()
>    esp.c: use deferred interrupts for both DATA IN and DATA OUT phases
>    esp.c: remove DATA IN phase logic when reading from FIFO
>    esp.c: zero command register when TI command terminates due to phase
>      change
>    esp.c: remove unneeded ti_cmd field
>    esp.c: don't raise INTR_BS interrupt in DATA IN phase until TI command
>      issued
>    esp.c: move non-DMA TI logic to separate esp_nodma_ti_dataout()
>      function
>    esp.c: process non-DMA FIFO writes in esp_do_nodma()
>    esp.c: replace get_cmd() with esp_do_nodma()
>    esp.c: move write_response() non-DMA logic to esp_do_nodma()
>    esp.c: consolidate end of command sequence after ICCS command
>    esp.c: ensure that STAT_INT is cleared when reading ESP_RINTR
>    esp.c: don't clear the SCSI phase when reading ESP_RINTR
>    esp.c: handle TC underflow for DMA SCSI requests
>    esp.c: remove restriction on FIFO read access when DMA memory routines
>      defined
>    esp.c: handle non-DMA FIFO writes used to terminate DMA commands
>    esp.c: improve ESP_RSEQ logic consolidation
>    esp.c: only transfer non-DMA COMMAND phase data for specific commands
>    esp.c: only transfer non-DMA MESSAGE OUT phase data for specific
>      commands
>    esp.c: consolidate DMA and PDMA logic in DATA OUT phase
>    esp.c: consolidate DMA and PDMA logic in DATA IN phase
>    esp.c: consolidate DMA and PDMA logic in MESSAGE OUT phase
>    esp.c: remove redundant n variable in PDMA COMMAND phase
>    esp.c: consolidate DMA and PDMA logic in STATUS and MESSAGE IN phases
>    esp.c: replace n variable with len in esp_do_nodma()
>    esp.c: implement DMA Transfer Pad command for DATA phases
>    esp.c: rename irq_data IRQ to drq_irq
>    esp.c: keep track of the DRQ state during DMA
>    esp.c: switch TypeInfo registration to use DEFINE_TYPES() macro
>    esp.c: add my copyright to the file
> 
>   hw/scsi/esp.c         | 1371 ++++++++++++++++++++++-------------------
>   hw/scsi/trace-events  |    1 +
>   include/hw/scsi/esp.h |   18 +-
>   3 files changed, 727 insertions(+), 663 deletions(-)

Any other thoughts on this series, particularly from SCSI maintainers? I appreciate 
that it's not the easiest one to review, and I'm grateful for the T-B tags received 
so far.


ATB,

Mark.


