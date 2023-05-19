Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B25D709115
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 09:59:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzv0A-0007jq-V4; Fri, 19 May 2023 03:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1pzv08-0007jh-38
 for qemu-devel@nongnu.org; Fri, 19 May 2023 03:58:12 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1pzv05-0006RJ-3C
 for qemu-devel@nongnu.org; Fri, 19 May 2023 03:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hF8+9yCwGdkxjpxCSDFvwka6RKbl27n0Vtjdw1OrHKo=; b=YAwfKRblfJ3UrhKJYKJRRf987U
 4zw5AxeU47HiTKSEL8bERPzhPSc36GRuPtdeK/7u5W1wUbCGYQsYNKTa57G9GDh09cqYkckkEn5X1
 MoYOsZEPXxEy/ISOEXCBScSqR4/8UN4nhnUo2YWzsyjLSuiAN2xrDn54ilXLg030js38LjW83SesP
 VVEIO26+qvWND+aub0l8u5Ts1aVgp3XYjVwh47qJhB8JR3YKZL1i/53YkGT0iV4nyCepcosf1Ah7U
 E3Ro//xEyUG2sTR7exHeyvnOrLOe9Wp1qGpSi7IyMWSvRAQmoCdn3AFHwZw4OfG3txMuVUcdQKlSA
 rXpQxx/NpxgnOWEx7itCC4lpVJaQNHWCEjS9JQCgGBkYyF4mYv4lED3E0L6gVJAB/lOn0SmqwHhXz
 135o/XC4CMAee+eb13lApPZBBbyCw89vKYwmYxhoBWY/A9tTGi/xntIs7l4WnzfAYCaM9GY7UEbse
 +NrKy7YsdPNiVlzPMCdjTI1KTBxM9lu54+6YXjJBG5qnw4IbhleHUI113xNBznt6oUA+ZsTasFg+o
 H5Uc7EwBVJKMOVdaGWqKA9it7vjbGBfxqDUN39H0dOQQrf8eYRrMhJVL+O1e7vXWEwutJRd80mH3r
 /w3rsWnh4eVwz6eUsCKn2J0PyhMysh1Z3UokKd0c4=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1pzuz4-0007Y0-Sz; Fri, 19 May 2023 08:57:07 +0100
Message-ID: <5e925b1e-e1ce-ed86-404d-ed214727bfb7@ilande.co.uk>
Date: Fri, 19 May 2023 08:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <58b8067d-3136-94ed-f53e-2ccd0feb8c75@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <58b8067d-3136-94ed-f53e-2ccd0feb8c75@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: gitlab shared runner time expired
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 18/05/2023 20:26, Richard Henderson wrote:

> So, here we are again, out of runner time with 13 days left in the month.
> 
> Did we come to any resolution since last time?  Holding development for that long 
> just isn't right, so I'll continue processing the hard way -- testing on private 
> runners and local build machines.

Since Daniel's latest gitlab series has proved that variable substitution can work 
with our gitlab template setup, I believe it should be possible to add some rules 
that can redirect pushes to the qemu-project "staging" branch for members of a 
"committers" group to the private runners (such as the ones set up by Eldon).


ATB,

Mark.


