Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2577721E18
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 08:29:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q63h0-00039e-FQ; Mon, 05 Jun 2023 02:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q63gx-000390-E0; Mon, 05 Jun 2023 02:27:47 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q63gv-0001dZ-Ml; Mon, 05 Jun 2023 02:27:47 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-52cb8e5e9f5so2999524a12.0; 
 Sun, 04 Jun 2023 23:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685946463; x=1688538463;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7seHjW125IaIXoR+X6oyctUEk+wkrO9C3/PaEcsGVFA=;
 b=JyYjOimJiN9HoJlQHbsKZBFhDDqSNWlDuoIJCv0FhfP4Dk8ClvFFcagVavbUl27Jqj
 UPU0eEOzwFp/mlrAJ1NupmeKteOHJ3KtEh19o+iA7MKSwmHAXlcX8qCttIPwP74kQMjV
 +NcLljj4RtItxMVQGX2uhfLRcotnd8FCqmUy1cZsncGXZpplx70AX8NbfbXICNTzo1jt
 LV/dkUgo311OjfuF6AF0I+GX8FXBfNBsPhITS8fqE5pzzlDxmso0A2YTJo/zvw4n621U
 h3KNNMnKHEGEXq90wvi1mGTv9O+mI3/rJmooyrTBUoDe9V60ziC81gv2bHngLlGiD00G
 8ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685946463; x=1688538463;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7seHjW125IaIXoR+X6oyctUEk+wkrO9C3/PaEcsGVFA=;
 b=hPNWt9KdBZDvvMr+BFjGvuNQeUidGKBWd5rzFzC/aHbEhj3so78VwBeXaAKCwRe3wX
 Q5ECxPtpkPPdPrD144zp9iKwOqbnEXZ74t2kh8znfQwGthKxD+4ZWIZIs0zb2FZVlDOF
 C414Q/UwODhad2M1Hf0tYhbccnMZhU72NMo6GHB8wBwps7DXbNi3NZGFPQOta1RfRFY4
 EX/4BVWlvsmEAUCLCJX0YHpnSfGMLNa38HRDq3b6FzfHk4LI8ZFSUu8/FB0urEkZcp4u
 vDD0UIIgNfg/q1agagDA+be9LtDhrXdArR0KJVmQ6EjViiBV3AMb//eS/jhGTlIJ47vA
 5iOA==
X-Gm-Message-State: AC+VfDyDxYXVeVMcE+HPtE5gcoSUeaItPIXT00pUSnncXHDtxCeJofB+
 56nv2tFPbcse9PXlalhU2kw=
X-Google-Smtp-Source: ACHHUZ7CsfCIo5to75o/lGhcJEGkj1+9gqwJskZmood25T6s3swvF3GKFLRZQPnB23TfQGGoNwPp7g==
X-Received: by 2002:a17:90b:e8b:b0:253:6b3a:ab1e with SMTP id
 fv11-20020a17090b0e8b00b002536b3aab1emr7769122pjb.6.1685946463441; 
 Sun, 04 Jun 2023 23:27:43 -0700 (PDT)
Received: from localhost ([203.221.142.9]) by smtp.gmail.com with ESMTPSA id
 p13-20020a17090a348d00b0025929bacd98sm2364933pjb.50.2023.06.04.23.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jun 2023 23:27:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Jun 2023 16:27:37 +1000
Message-Id: <CT4I52C30RXG.AESIFCY16U6T@wheely>
Cc: "Richard Henderson" <richard.henderson@linaro.org>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 2/4] target/ppc: Ensure stcx size matches larx
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
X-Mailer: aerc 0.14.0
References: <20230604102858.148584-1-npiggin@gmail.com>
 <20230604102858.148584-2-npiggin@gmail.com>
In-Reply-To: <20230604102858.148584-2-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun Jun 4, 2023 at 8:28 PM AEST, Nicholas Piggin wrote:
> Differently-sized larx/stcx. pairs can succeed if the starting address
> matches. Add a size check to require stcx. exactly match the larx that
> established the reservation.

Hmm, question: reserve_addr is a VMSTATE field, but reserve_val is not
(nor reserve_size after this patch).

Blue Swirl added that with commit a456d59c20f ("VM load/save support for
PPC CPU"), and when reserve_val was added in commit 18b21a2f83a
("target-ppc: retain l{w,d}arx loaded value") it did not get migrated.

Could we end up with reserve_addr !=3D -1, but with a bogus reserve_val,
which could then permit a stcx. incorrectly? Not entirely outlandish if
reserve_val starts out initialised to zero.

Could we just clear the reserve in cpu_post_load? It is permitted to be
lost for an implementation-specific reason. Doesn't seem necessary to
try keep it alive over a migration.

Thanks,
Nick

