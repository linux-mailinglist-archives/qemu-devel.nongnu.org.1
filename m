Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B362D7F656F
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:31:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6DWS-0000Qa-Mf; Thu, 23 Nov 2023 12:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1r6DWR-0000QP-0t
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:29:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1r6DWI-0007eA-9j
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:29:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A1EA51F362;
 Thu, 23 Nov 2023 17:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700760579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+zv2Rs04/xFlc5JoVO/vz1RVVttMkRKxYHZhhJD4RQ=;
 b=H4+hA8VRpMf/JhhOWc1s0Ox0QbD2Db8zDCcbeRsX2n4l6rg+rI/bfuQSMFanzzyIWyLamY
 vPiRl3AIUEnaWnCW23IGJhBp675K19XmXyWRW6PDgO2Ni3Tz3u0TZZM3K2RJ51GKKuEmI3
 7CCsAEu8WzDft1gnAjoUfmB9veEpMv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700760579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+zv2Rs04/xFlc5JoVO/vz1RVVttMkRKxYHZhhJD4RQ=;
 b=lCxuWhACAqOtBZBpg+9aRxkuTA1Cs1gtXwkIX13ue+xUStWVrR2Ts2/03v6P35YuxHQ3GB
 UDaKtMDszRExayAg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 655E52C15F;
 Thu, 23 Nov 2023 17:29:39 +0000 (UTC)
Date: Thu, 23 Nov 2023 18:29:38 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex Benn =?iso-8859-1?Q?=E9?= e <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231123172938.GU9696@kitsune.suse.cz>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <4l0it.9kkxe9s135lg@linaro.org>
 <791c81ad-e98d-4eee-9ca7-f3157977913c@linaro.org>
 <20231123104336-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123104336-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: ++++++++++++++++
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of msuchanek@suse.de) smtp.mailfrom=msuchanek@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [16.98 / 50.00]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(3.00)[1.000];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(1.20)[suse.de];
 R_SPF_SOFTFAIL(4.60)[~all:c];
 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 RCPT_COUNT_TWELVE(0.00)[16]; VIOLATED_DIRECT_SPF(3.50)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 BAYES_HAM(-0.01)[47.40%]
X-Spam-Score: 16.98
X-Rspamd-Queue-Id: A1EA51F362
Received-SPF: pass client-ip=195.135.220.29; envelope-from=msuchanek@suse.de;
 helo=smtp-out2.suse.de
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

On Thu, Nov 23, 2023 at 12:06:59PM -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 23, 2023 at 04:29:52PM +0100, Philippe Mathieu-Daudé wrote:
> > This document targets all contributors. Contributions can be typo
> > fix, translations, ... and don't have to be technical. Similarly,
> > contributors aren't expected to be technical experts. As a neophyte,
> > "AI" makes sense. "Idempotent code generator" or "LLM" don't :)
> 
> I don't think there's any big deal in using AI for typo fixes.

For how many typos it is still OK, and would not a deterministic
spellchecker be preferred?

There are some edge cases where using AI is OK, the problem is most of
the time it is not clear it is OK to use.

Thanks

Michal

