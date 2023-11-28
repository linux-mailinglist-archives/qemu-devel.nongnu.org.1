Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BA07FAFC3
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 02:49:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7nCh-0000Bl-Ph; Mon, 27 Nov 2023 20:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7nCc-0000BC-QJ; Mon, 27 Nov 2023 20:47:54 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7nCb-0005zS-Bj; Mon, 27 Nov 2023 20:47:54 -0500
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-359c22c44d6so20478775ab.2; 
 Mon, 27 Nov 2023 17:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701136071; x=1701740871; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PItxwjB0fhJcmuKAKG+2+P2tnvj6NJ5t5MCqMq3owTM=;
 b=RmkTOgFUpSLQJi/auN7FQfVawX/eYk8T6OatrwwNPOb1nnqKHZ3AoWK7TCW0wQLtWM
 vWNx0YRYqizwJmSdRjSWfWiVeOgGi2bkcZvDuhdA7ara77vCCkDjavxoByMHJ89xax7Q
 pg3YixTqhvw4EMu/bw0MDqxCqS+1MH354vp9WjBLWh4nvUxvm5euXgUZCPtUL6qwVIqU
 p8rZ9jEAnyuEmmBAW4bSUDstOPsYqKVOX2BWFN8Q/m/qb6I3iro4NQ1io2ypQmTw4D82
 wkDBPIuExzIcRJg0uBCGosYDz2odkBfJLYijXvIxGVhY7UaWvOskPyVlHVI88j/TLSM/
 H5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701136071; x=1701740871;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PItxwjB0fhJcmuKAKG+2+P2tnvj6NJ5t5MCqMq3owTM=;
 b=ekqdB2AMVYGKOluCF0yFNcthdAdt4A9J9zUm/saCmzfphraCK5ejOZqxI5Efr6CFVu
 vVAtf6b6QOMvY+rWniLtA0f+TZPRsjH6DdCyWsjrppM4T/JiRNiLQUOziwFIJbDCN+I3
 aa6/iutuvknudTEBJtTV/hHzOwhMdHeO7qw1Har9jHtGCBAqu2U3z9RP7fvGbhnabELA
 gPXR7MvVbegN0Kx0zHj+F5zWFBiJq0qRbIyexNsjzGz923svUNJ+EvFAkLMPMDZ+8AOP
 6ZrWtEq/6WHbwKgxCCgdUaFz3xIr6aW8qahB2EgLb4kUhEDVHhcKy3ue5qiUI8KRP4ml
 rOBQ==
X-Gm-Message-State: AOJu0YzgTg7gH8uP9O2V1e3dYLce+laZoI/lermqyQ8YHU9S0id0YWvq
 HFUJn9Iebyn63A+JD50B4Sg=
X-Google-Smtp-Source: AGHT+IH0GRkdqRukrLVtsAYzgPsXeO1xMNv9gdmH6PBFI6YZnrfMUaSdYly14fLR3fNzXj7soUydmQ==
X-Received: by 2002:a05:6e02:cb3:b0:35c:7b32:23fb with SMTP id
 19-20020a056e020cb300b0035c7b3223fbmr12793494ilg.22.1701136070983; 
 Mon, 27 Nov 2023 17:47:50 -0800 (PST)
Received: from localhost (121-44-66-27.tpgi.com.au. [121.44.66.27])
 by smtp.gmail.com with ESMTPSA id
 37-20020a631365000000b005b8ea15c338sm8308547pgt.62.2023.11.27.17.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 17:47:50 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Nov 2023 11:47:45 +1000
Message-Id: <CXA2ENP9VBT1.2THPXM7WFD3I3@wheely>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, <philmd@linaro.org>
Subject: Re: [PATCH v2 for-8.2] ppc/amigaone: Allow running AmigaOS without
 firmware image
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "BALATON Zoltan"
 <balaton@eik.bme.hu>
X-Mailer: aerc 0.15.2
References: <20231125163425.3B3BC756078@zero.eik.bme.hu>
 <CX9EPBH7MMHK.14A30GV035VAZ@wheely>
 <0eb18a77-af0e-a84b-764c-b435ea912a3d@eik.bme.hu>
 <CX9LVFYU6MBA.MLF4OMOCHE6K@wheely>
 <3f188a09-9927-4fc3-a4eb-0cde34934539@kaod.org>
In-Reply-To: <3f188a09-9927-4fc3-a4eb-0cde34934539@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x12a.google.com
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

On Tue Nov 28, 2023 at 2:37 AM AEST, C=C3=A9dric Le Goater wrote:
>
> > I'm not sure, I don't think it's necessary if your minimal patch works.
> >=20
> > I'll do a PR for 8.2 for SLOF and Skiboot updates, so happy to include
> > this as well.
>
> I think this is a bit late for 8.2 to change FW images, well, at least
> SLOF and skiboot. Are the new versions fixing something critical ?

Ah okay. Well then I can put them in next instead.

SLOF has a fix for virtio console over reboots, pretty minimal.
skiboot has some bug fixes but it's a bigger change and maybe not
so important for QEMU.

Could they be merged in next release and SLOF tagged with stable?

I think this amigaone patch could still be merged since it's only
touching a new machine and it's fixing an issue of missing firmware.

Thanks,
Nick

