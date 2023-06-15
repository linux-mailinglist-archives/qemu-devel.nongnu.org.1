Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4228A730CE3
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 03:51:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9c8T-0002dU-DD; Wed, 14 Jun 2023 21:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9c8R-0002d8-Tz; Wed, 14 Jun 2023 21:50:51 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9c8Q-0005fN-ER; Wed, 14 Jun 2023 21:50:51 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6667defb5a3so771108b3a.3; 
 Wed, 14 Jun 2023 18:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686793849; x=1689385849;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T45pNwHBH1hcIlYKm+UhWs7uJEvyrrUNRz7ru65DkZg=;
 b=S0zIP2bbm4b762OdOAEdgWHSqiFBvkHztTk58E8RrhOfnXt6wem6uWRYKZYAWUD1O4
 EgaT1LdJsw4h8uknOHHVqSgRRCKgxgiPktOUVIHMjKOf5hLTi1MvHB9M5R5rHUvviphw
 pxMGfTw6/RwFiHR5xDaBdIg8E8A5z22/csUPdJBV9d7cXtt5P01j9r+NozbuOhuPhh/+
 AA3xRf5W2LVfDc4FZ7Rmr97dOuJGb2nICY8Jv7z9TL7rcLlRJgF/cABXcAl7EoudqEu4
 IEuuXHNVc/Ps+uXBwzyqBvKRJNoAkmWln4j67DfbAv8ehx0YOzQ6lj+OFV7GRYCeJwQG
 TiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686793849; x=1689385849;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T45pNwHBH1hcIlYKm+UhWs7uJEvyrrUNRz7ru65DkZg=;
 b=Eqbosvx3xNYcj/4xVvwZ56mxwPxtUd39c216A5M1TdKql3v46sVzlWtkjYHq0ztJff
 0nBigGMX/7HQUHIEDBkt0WRpMZG9NgB/2PUNAzWng5Pl8warIZsgO/tHEkfnzgIiBJ5p
 pFLhxBXbWXk9IPloSpI+kdqr53iCjS2gzAgEcRnoTAjKBncGXB9QG5qJ46syZrHVHEII
 MgFbCeVeMc9CFJB2Dx5fKo8x6bP4+lhCQLRz9EbDBmmP/PYe83u6YL8VIce84Q3L2zHT
 YhDfoQXa4YMlx1ceN25YRgdyP/xQHKwVmIlcGZltJ+jhILR/g1Fmh/a+W99YVUKeCETT
 yQ9Q==
X-Gm-Message-State: AC+VfDxQORermw4MSzLGXmCTHP1tC2R+2p71e2clOvZxbhPzPXhfZ5/N
 QRswg8uJV2uYNaXHmrpa72ENSOn5D04=
X-Google-Smtp-Source: ACHHUZ7nM/scm1dPb/S/omq+5cfkPFkPSlGy+dDg9SHc4HR9309eyK6lUnxZcc8OPJ+n2wVzLVMgiQ==
X-Received: by 2002:a05:6a21:6da8:b0:10f:9bea:5a61 with SMTP id
 wl40-20020a056a216da800b0010f9bea5a61mr4525144pzb.2.1686793848608; 
 Wed, 14 Jun 2023 18:50:48 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b006528d9080f6sm10907119pfn.9.2023.06.14.18.50.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 18:50:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 11:50:43 +1000
Message-Id: <CTCUII5CGI0M.3JI6CB71U0P6B@wheely>
Cc: "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH 03/10] target/ppc: Move common check in exception
 handlers to a function
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "BALATON Zoltan"
 <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <e7c1a61de1efdee932b71fada93dd58a3ce951cb.1686522199.git.balaton@eik.bme.hu>
 <CTC23Y9FHUQ9.2CDYVQ4WJ58L0@wheely>
 <49f4e25f-e0a5-4941-a2bc-8e273cac6eaa@kaod.org>
In-Reply-To: <49f4e25f-e0a5-4941-a2bc-8e273cac6eaa@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

On Wed Jun 14, 2023 at 4:25 PM AEST, C=C3=A9dric Le Goater wrote:
> On 6/14/23 05:35, Nicholas Piggin wrote:
> > On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
> >> All powerpc exception handlers share some code when handling machine
> >> check exceptions. Move this to a common function.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >=20
> > Hah, I just did very similar to improve some checkstop code (but I can
> > rebase my patches on yours).
>
> The mce injection was a nice addition. You sent that a while back for pse=
ries
> and powernv. Are you going to revive the series ?

Yeah I do plan to.

Thanks,
Nick

