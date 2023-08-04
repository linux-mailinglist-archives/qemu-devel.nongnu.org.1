Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD2176FE52
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 12:20:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRrv7-00040b-S2; Fri, 04 Aug 2023 06:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRrv5-00040S-G9
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:20:31 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRrv4-0005V8-0h
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691144426; x=1691749226; i=deller@gmx.de;
 bh=IlY2i5dGk+i+YkaDn0AKgJhrmGSvYSsTWhE06jwADac=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NlhrhIUDRwC9ot7gDj/pN/YtxnJ2G+aaHjGSVmQWRlJywnVtVahtZppfJznAh1nT47ye/TF
 q4dOP5xJye/MhTs5kTcn1ODoAWp14ea2DT64cGtUxxQKhKO1dmvu3xurO7MOD8uVntfIpke6t
 I7Z57seEUTfoZ4ennWaGqp/lAa+gMwB+lrdUwBJRokv3aUn/9oQznLstJDWY57GnIfjim8f0p
 yAo1T9cSpKhyeTiqeoqC9UGbiOt9+f/roVdoX20M3yf5V1IJSgssklDHC9P8H1D/RjASN6nGL
 hQGIYzknANdNiuH8EVWyf2dtV0N9HUNnPXr0FpqFUQVhNP/G7mdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.152.187]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdeX-1qeGVz1WNh-00EaKt; Fri, 04
 Aug 2023 12:20:26 +0200
Date: Fri, 4 Aug 2023 12:20:22 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, joel@jms.id.au, akihiko.odaki@daynix.com,
 laurent@vivier.eu, deller@gmx.de
Subject: Re: [PATCH v8 12/17] linux-user: Use elf_et_dyn_base for ET_DYN with
 interpreter
Message-ID: <ZMzQ5n8skaU+6Yxu@p100>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-13-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804014517.6361-13-richard.henderson@linaro.org>
X-Provags-ID: V03:K1:xyNbz8FkB1SLGAsAxSUSDbjRg+jwhwnGwd2p2xK5xPnncfkxHmw
 4WjiQyEhPbq3A0DXZxUnqT7VmEH8oO+BpL4T5WTr+6ajEOErtZpWOHX2ZuHvXW7M4kh2M6u
 5rX4vt4FNo7pR9q+BPa6jBWvtMgNRc5OlsUkqjOleOr71uUuYy6v1wNQqXfTUg+EXQxSo7o
 Jgc4xsGDhcahDmQhFHP3g==
UI-OutboundReport: notjunk:1;M01:P0:e3u6AtUYTIY=;poSjL+477g/z+QKXSAiMooFlIx+
 X0jFc3z0IMSBRHJ/vESLIIJAmrcY4q6rNCwxJOU7BXjsnRFp55XR6D+ICfIgbssFYiMECC4QX
 pVc0l02+TcxFNZTPEGVc/xYaL2Xlyviz4b3hgf6aBwTcUh6hMz8Hs893QS3uhgf9SxMMJpQDx
 pmUEXLnxcAcQ2VOju+mXf84dh7jJba73+10zEClC4MW9yTNHGGrLwkufT/ZwnPFDdj1dozFz7
 l4rCAdF/2lfGxcsPU/b9MrHqeMjN6k4ceij9zTILKGI7bE0YxPfiExDEIwFOWGpTxrUhaIHLV
 NdbdRdmpobkBatzs28vLmzA1Dl4Ipsa78SOf+yKLJx6++GLsV7d0ROaYCKSZYWNmve2cRSkVM
 FCWS01DzYjSFGSUT+IHZf2ci6tj/itHKV5sDHvrsXVwi/Miop/N07YM6KAzAsxWa99DegDZ6h
 CdR8PFvFD72pAFkVWj4Q8yRcGlZ0R2mpjDWBnlFrwWiwo/Y9NdLCQ4TiDVKod+iqj4MFlg2XF
 HOeSAokXRqVVdwb2iBbfvZxnfIj3kGCAXJtEIATM/mOm+Pmlnolk9/ewV+kQfw60AEFZLz+1X
 BkEBAd1dg7V6AIrXtFn0Wg4ZqL4mRqOWEyV7xqYBHFjsYckVcwT8nE4SX/4UACowO1wJeKBZ8
 8Ix00XUUfZbET/44DiGFrqSupgIi0zz6H0cFdzQcN+lMbIB/nX+vRsFbSd6TYuRiJctlAHf50
 AgQxForDxLZ/+G4NkjCnYkSSWULHzBP+aYAp2TJTv5ZKlIgCCH6/Zm9xoM3dtKFPZ5o8K3fMf
 nHV563Cv7/ZMb/nV5fKWnafESiprAMaebRctMpKwL0wMBPAuthfb21hbx70ox+RkqmVXjpOar
 yb6hmnXh7/NRSsME6Pq5OoP2Ht3ispNlmlR/8XGgx/mYZ7uxjOBHq5J1LAo1Qudj0jL+GYuIn
 Hg2XasLy+K28Vf7JR2+UqM01Uy0=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

* Richard Henderson <richard.henderson@linaro.org>:
> Follow the lead of the linux kernel in fs/binfmt_elf.c,
> in which an ET_DYN executable which uses an interpreter
> (usually a PIE executable) is loaded away from where the
> interpreter itself will be loaded.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

