Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FAB7DBB1C
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 14:52:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSfr-0002zJ-Cj; Mon, 30 Oct 2023 09:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1qxSfp-0002yx-5U
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:51:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1qxSfn-0000FH-5I
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:51:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2C3841FE71;
 Mon, 30 Oct 2023 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698673875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pkpU+X21FVvS4NHs7RUoqE3zEoT5Bp0SlUAkteTqemg=;
 b=gr5gn1rl0Vxg3WigN4gHstUVRJxk/x4LniiHbvMU5vYh0q473Q8MVgvU8GMo8+7LdWcP6D
 GXtvKQgX6BS0FV0EayibTuWCz7mkCi/YQ58y3bDqMgqqSd5UlLoKlOaoEdrRhqGtPPNTAK
 eSJsmF8ThVgbtkAHVQX0a0FxqOrSKnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698673875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pkpU+X21FVvS4NHs7RUoqE3zEoT5Bp0SlUAkteTqemg=;
 b=27nJs239FCA/iaM1GaDPbBBDtg577VnYv+l9tNDjbSvvxHdqJ7Bdfmygf7uXTPugaZyuTn
 3SCUWkNeLsZZYbCw==
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by relay2.suse.de (Postfix) with ESMTP id A829B2C188;
 Mon, 30 Oct 2023 13:51:14 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id D9B0E4A0396; Mon, 30 Oct 2023 14:51:14 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [RFC PATCH] target/m68k: Use i128 for 128-bit load/store in
 m68k_copy_line()
In-Reply-To: <8c85fc54-3933-4330-a378-c1b444b0771f@linaro.org> (Richard
 Henderson's message of "Tue, 17 Oct 2023 06:52:50 -0700")
References: <20231017122702.39311-1-philmd@linaro.org>
 <8c85fc54-3933-4330-a378-c1b444b0771f@linaro.org>
X-Yow: America!!  I saw it all!!  Vomiting!  Waving!  JERRY FALWELLING into
 your void tube of UHF oblivion!!  SAFEWAY of the mind --
Date: Mon, 30 Oct 2023 14:51:14 +0100
Message-ID: <mvmbkcg6wx9.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=schwab@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Okt 17 2023, Richard Henderson wrote:

> The manual says "burst reads and writes" without defining those terms.

Burst transfers are explained in the M68040UM (7.4.2 Line Read Transfer
and 7.4.4 Line Write Transfers).

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

