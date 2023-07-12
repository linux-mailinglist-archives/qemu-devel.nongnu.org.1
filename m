Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8361574FCFA
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 04:14:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJPMD-0003Mp-Pq; Tue, 11 Jul 2023 22:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qJPMC-0003Mb-33; Tue, 11 Jul 2023 22:13:32 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qJPM9-0000HD-Ib; Tue, 11 Jul 2023 22:13:31 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-55ba5fae2e6so4709863a12.0; 
 Tue, 11 Jul 2023 19:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689128007; x=1691720007;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMEK6PyWFyZJG+UEe4/8cdH0mTVQ10OBz8JGtqScqLM=;
 b=FWuGmnx7RlH0E4QVFWF/exn2RV5+7s7mF2UGnkPBH3juzOk4PbEP5JWjE5adRItPVU
 RBaCBPtB1lzwtwi2ESC75qhA6oJyb3f6fvcT7XOSI12LG1yYqoEtoPZCBlGFkt1T+hd9
 YPiVgSnmbFQRYZsulxrEzQCFXQ9JhhVuO/ozttGbx82OaZwB50yTUfHC3Bsuzfv6n9At
 e+oS+KDaWH1mhoI31KDnuPDiDeEYO2wtlzDrma1oZiN4biYWNUYwsOhph5uv9KsHqrhX
 aJ45f4vPdK+Um+Vy/jBTTgpzA6noxXc/WQtk8UvEFYjDLx71sEQg4bmos9D0SjhZ9qZC
 GOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689128007; x=1691720007;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CMEK6PyWFyZJG+UEe4/8cdH0mTVQ10OBz8JGtqScqLM=;
 b=FZVEEncUVEqPiUfjju/WeOyzk4HxvDt7xUGGfHVZjtVCmm/nxzjlQH2gNxsS3VHFOV
 e9t+3MaXRPJOZz0V7xpQY/5Ep2YsZ7j1v2O4wrRmyNUMhOK1o7Ie1FcetDvlR7D3uv00
 2ugX0RDlj9+8D7DDaL2v6vCetWqtpw7krrJs/YmgDmprtN52QqtvSBy8Hd6f+MqfEuRm
 zE0Oa/SiJN7Tugfwg3VbljRj2FiN/DqbRRexg65oyJWvQXpC1G/+PyX00fcX5S6JHs2r
 XIgKY+InNIM+ocRZBGSYfDCJETBilj74wEc0kts/RTtKK6HXolkAtj9UQnz8fYmKMxx2
 x8TA==
X-Gm-Message-State: ABy/qLZsUG6NnFyoJdpGVDOMn07Vk61Geuk76p0K7XF45YPwgFw0rdUK
 OgKPEN3Sou/kgQGwiCC68EU=
X-Google-Smtp-Source: APBJJlELnquw3cVUv2UjPOhERQ/rd5pRdFy0zzor8MZFtL80VZ6iL9RfP/f/V41EXYJ5vWchenZIAQ==
X-Received: by 2002:a05:6a20:728a:b0:11f:626e:15b4 with SMTP id
 o10-20020a056a20728a00b0011f626e15b4mr21947999pzk.44.1689128007614; 
 Tue, 11 Jul 2023 19:13:27 -0700 (PDT)
Received: from localhost (193-116-64-199.tpgi.com.au. [193.116.64.199])
 by smtp.gmail.com with ESMTPSA id
 s17-20020aa78291000000b006827c26f148sm2342134pfm.195.2023.07.11.19.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 19:13:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Jul 2023 12:13:20 +1000
Message-Id: <CTZTWJ73RQFY.1ZX05ZTD1FIWA@wheely>
Cc: <qemu-stable@nongnu.org>, "Matheus Tavares Bernardino"
 <quic_mathbern@quicinc.com>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Taylor Simpson" <tsimpson@quicinc.com>,
 "Frederic Barrat" <fbarrat@linux.ibm.com>
Subject: Re: [PATCH] gdbstub: Fix client Ctrl-C handling
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230711085903.304496-1-npiggin@gmail.com>
In-Reply-To: <20230711085903.304496-1-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
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

On Tue Jul 11, 2023 at 6:59 PM AEST, Nicholas Piggin wrote:
> The gdb remote protocol has a special interrupt character (0x03) that is
> transmitted outside the regular packet processing, and represents a
> Ctrl-C pressed in the client. Despite not being a regular packet, it
> does expect a regular stop response if the stub successfully stops the
> running program.
>
> See: https://sourceware.org/gdb/onlinedocs/gdb/Interrupts.html
>
> Inhibiting the stop reply packet can lead to gdb client hang. So permit
> a stop response when receiving a character from gdb that stops the vm.
> Additionally, add a warning if that was not a 0x03 character, because
> the gdb session is likely to end up getting confused if this happens.
>
> Cc: qemu-stable@nongnu.org

Oh, I should note that this doesn't apply to any stable
branches I'm sorry. Will be more careful with the tag...

Thanks,
Nick

