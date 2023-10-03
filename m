Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3787B6D47
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:38:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhSD-0003t7-P6; Tue, 03 Oct 2023 11:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qnhSB-0003sv-L2
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:36:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qnhS9-0002sl-QD
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:36:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3BF7727257;
 Tue,  3 Oct 2023 18:37:28 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1DFA42C923;
 Tue,  3 Oct 2023 18:36:43 +0300 (MSK)
Message-ID: <b9cae1c5-1c8b-6ffe-9200-053476defe44@tls.msk.ru>
Date: Tue, 3 Oct 2023 18:36:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 00/24] Audio, build system, misc fixes for 2023-10-03
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabiano Rosas <farosas@suse.de>
References: <20231003083042.110065-1-pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -79
X-Spam_score: -8.0
X-Spam_bar: --------
X-Spam_report: (-8.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.09,
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

03.10.2023 11:30, Paolo Bonzini:
> ----------------------------------------------------------------
> * fix from optionrom build
> * fix for KVM on Apple M2
> * introduce machine property "audiodev"
> * ui/vnc: Require audiodev= to enable audio
> * audio: remove QEMU_AUDIO_* and -audio-help support
> * audio: forbid using default audiodev backend with -audiodev and -nodefaults
> * remove compatibility code for old machine types
> * make-release: do not ship dtc sources
> * build system cleanups
> 
> ----------------------------------------------------------------
> Akihiko Odaki (1):
>        accel/kvm/kvm-all: Handle register access errors
> 
> Fabiano Rosas (1):
>        optionrom: Remove build-id section
> 
> Mark Cave-Ayland (3):
>        esp: use correct type for esp_dma_enable() in sysbus_esp_gpio_demux()
>        esp: restrict non-DMA transfer length to that of available data
>        scsi-disk: ensure that FORMAT UNIT commands are terminated
> 
> Martin Kletzander (5):
>        audio: Require AudioState in AUD_add_capture
>        Introduce machine property "audiodev"
>        hw/arm: Support machine-default audiodev with fallback
>        hw/ppc: Support machine-default audiodev with fallback
>        audio: propagate Error * out of audio_init
> 
> Paolo Bonzini (14):
>        e1000: remove old compatibility code
>        pc: remove short_root_bus property
>        make-release: do not ship dtc sources
>        meson: clean up static_library keyword arguments
>        Makefile: build plugins before running TCG tests
>        crypto: only include tls-cipher-suites in emulators
>        ui/vnc: Require audiodev= to enable audio
>        audio: allow returning an error from the driver init
>        audio: return Error ** from audio_state_by_name
>        audio: commonize voice initialization
>        audio: simplify flow in audio_init
>        audio: remove QEMU_AUDIO_* and -audio-help support
>        vt82c686 machines: Support machine-default audiodev with fallback
>        audio: forbid default audiodev backend with -nodefaults

I'm picking the following items:

  Fabiano Rosas (1):
         optionrom: Remove build-id section

  Mark Cave-Ayland (3):
         esp: use correct type for esp_dma_enable() in sysbus_esp_gpio_demux()
         esp: restrict non-DMA transfer length to that of available data
         scsi-disk: ensure that FORMAT UNIT commands are terminated

for -stable (both 7.2 & 8.1).

Thanks,

/mjt

