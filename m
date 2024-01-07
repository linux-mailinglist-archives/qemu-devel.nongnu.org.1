Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3B582644E
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 14:51:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMTXS-0008UQ-Sf; Sun, 07 Jan 2024 08:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bruno@clisp.org>) id 1rMTXQ-0008UH-Ae
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 08:50:05 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bruno@clisp.org>) id 1rMTXM-0006nn-J6
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 08:50:02 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1704635376; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=SZBJhHJ04k/5FATj9J4hb//0KDlc8nnrQVDO+6oKVCSI2dWmbt0b4D6Hg+7Ipgr8Ox
 1WrXwFJu/7hhI1ex9LgKgZy+7Tu63spoaWH3WHP2VE/itb2dXh/ddpWcmfoPDD9gJ26W
 qy0dyIXimnbk13rPGPWS6yzIobHRK/vW0FrZ1xyaHpRYjCf3vi0+dU7sdv9J/8pYlu5w
 FaMQ0IffXT0djv1rCtYGJPTlpkXJFrCdZ+IXWQLxcITozwk0rAcbmkZyZUD7ooAziXds
 vxbSspEpQ6ElVglIPf1V7PbIhaR4MxOO2ROy5JIYeFyHsU4rMKS3jPeHZ4oMtSWtJNxy
 UEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1704635376;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=QYS9KrVstNp3FmF9ElPsd+DlWOtP/5RwV0akrqT+aFs=;
 b=C94OLPce4BRgxNyCO7SGMpVtBREaMM53wLJ/i64yUq7SrMLonycHDXj2ZryftBjp3T
 iHVqfk05eV9xLMPoLFRmF0GvLbB66STqVS6D2lFnrCG8vQBW5rmReQV9nR/aCXewA8RM
 6Mo65S1CmsdNhWAGiJEcF3EfiOInD9mQvhXYtKrI6X135rlaw4M3i0LAr8lwjovSU8T+
 FCVy6ZuOQlyBMG5kzTnb0/mfiYON9fR21MYn3Zr/csvI4YGrcv40TZB/sJ9P5RlcJpkY
 hgp9WZEVOvcEuZEzw0BIHmImYtypWzpHT60Ogm62ZUKCjYgr4NvVPwbn5Q5T/2KnVs/L
 KMDA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1704635376;
 s=strato-dkim-0002; d=clisp.org;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=QYS9KrVstNp3FmF9ElPsd+DlWOtP/5RwV0akrqT+aFs=;
 b=ZhtVxtbD2rdhErFXYWhaGld5iV6oqMU6PFfmfJunudl/EyJR3Or4aH+nYdQFPy6exH
 7uqLMkOL44rVSLzdj4QImqLfDntSJ7FBh05gylwCPfsBKCya5hWmGHf105cdtxZdHAt+
 ISSloIsZcobCgjqtcGaVBQ4ClRtS9bQVGyzRpe5xIG2c1xLTxoGUI2e58GFr4Eh8HdmJ
 ivhnDSewqqRM0m6bNx34Brrkctesx8eFj2RXOro9hmaw22lto+Vi7GvJCP0cCu7EoJgO
 FNWVgGlp2IVAzN9LJu+jFd6oW5C/2F19b7zCGUppYJSeiSFjSCVZhPavL04JwJQOkgH7
 Vr8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1704635376;
 s=strato-dkim-0003; d=clisp.org;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=QYS9KrVstNp3FmF9ElPsd+DlWOtP/5RwV0akrqT+aFs=;
 b=AugCe768Yud1LLiUzSO/GuTyZ/mZhmrA/Bba1dozze2FG15b/hk41S5wxVS4KZLli4
 jgw1/lAftMhwzq2lg2AQ==
X-RZG-AUTH: ":Ln4Re0+Ic/6oZXR1YgKryK8brlshOcZlIWs+iCP5vnk6shH0WWb0LN8XZoH94zq68+3cfpPD3vYSqeIG7fhoi+aeu3rIgSgNhQ=="
Received: from nimes.localnet by smtp.strato.de (RZmta 49.10.0 AUTH)
 with ESMTPSA id j4bcad007DnXl5G
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sun, 7 Jan 2024 14:49:33 +0100 (CET)
From: Bruno Haible <bruno@clisp.org>
To: qemu-devel@nongnu.org, deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, "Nelson H . F . Beebe" <beebe@math.utah.edu>,
 Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 0/9] target/hppa qemu v8.2 regression fixes
Date: Sun, 07 Jan 2024 14:49:33 +0100
Message-ID: <2373201.NG923GbCHz@nimes>
In-Reply-To: <20240107132237.50553-1-deller@kernel.org>
References: <20240107132237.50553-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: none client-ip=85.215.255.22; envelope-from=bruno@clisp.org;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
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

> The whole series can be pulled from the "hppa-fixes-8.2" branch from:
> https://github.com/hdeller/qemu-hppa.git        hppa-fixes-8.2

Tested-by: Bruno Haible <bruno@clisp.org>




