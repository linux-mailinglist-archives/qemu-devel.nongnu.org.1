Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5601D8084AA
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 10:28:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBAfR-0008OW-67; Thu, 07 Dec 2023 04:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <talhak2111@gmail.com>)
 id 1rB9G8-0007RB-9e
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 02:57:24 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <talhak2111@gmail.com>)
 id 1rB9G6-00042u-1W
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 02:57:23 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5d40c728fc4so2817547b3.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 23:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701935839; x=1702540639; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BNATQZzoy2G0Ma5a45TaA2ekc1UO60t8D+n9C8Umc6Y=;
 b=AcBRFnd8uOaUz16E7YaJPkKrKKk+12Yw7KByQdCZX7llFvVXwlGzqQbseNvmaG/b9r
 M7SflZ/KozfCx27ONF4WvHEzQmvL/FJqZF5gpgX4O/YblZ2DttDvAtThLOs9tdAH0ztx
 Is5hT0IFF2whe5JeqCRrB1yMd9GFGyLN08dfCZwjh6MIlQdKk+GQgkQOZvVkjB+qhuk/
 aUdd7SdbROY9DPBtyr3lWFyq5KDRdb28X7snGi9XyBLU6I57yGMiOFcgPMrtPBspiqcy
 l0J5fl/YpUFUpbevFBS7I1RCsJ41KFAkwnLwGSV7WSggHa8YdXqYW09J5huKQaSd9I4z
 /LUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701935839; x=1702540639;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BNATQZzoy2G0Ma5a45TaA2ekc1UO60t8D+n9C8Umc6Y=;
 b=IG14DNRG/ha6fXy7qbaoTn6iSQseQ7i1xJ1e8Y+ePXyY8gsru5EujEenltt1r5oE7z
 3YsJwULG+ujZy0Kbuhgsdl2VOj687NV2HhYMz69vwgC9dBljCaClZDvDIHMxxvlsmMxL
 4LQX3i8TLAcrXXjCxsVPL0C2thE9j1TanbMl1aO3O/n5LvoUIZy7MfmzJ296p5FdGDkM
 3p2LvXhLh1BQXQwhSsThLx0GLpbAyvILcIsSr+k3sL5x5/B1ZwNLgCYPFSpG4RhVIkgh
 2kLcnEExH00srZTKDeV1Q/gQdLbB2GRNa3CASls05rmDg2V+4t+S7E3LdsASuOjGMKIf
 BPtw==
X-Gm-Message-State: AOJu0YzRMSY7sppxHtDsEPBc7gkvr5639D810QG3NvzcvwIE0kNk5Pko
 gj3mAEh8rSjz602cfaefjbLct1sHv0jc1uXzKWWZjGwp
X-Google-Smtp-Source: AGHT+IFKP5zlDfJqZcRW36sgsmyc8C58MXKtefh5XENaoYQNWIVZZlbACM+IeETF/+HNT6rWB01BuHhbUZ4NBPhOF1Q=
X-Received: by 2002:a81:9845:0:b0:5d6:2ebb:3b5d with SMTP id
 p66-20020a819845000000b005d62ebb3b5dmr3321332ywg.21.1701935838858; Wed, 06
 Dec 2023 23:57:18 -0800 (PST)
MIME-Version: 1.0
From: Talha Khan <talhak2111@gmail.com>
Date: Thu, 7 Dec 2023 13:27:07 +0530
Message-ID: <CAMnsxbAr3GyB6bpvrYMt-31Q+ZKuEoLm+i++CWs6thQmQUXtVw@mail.gmail.com>
Subject: Build qemu without USB,network devices
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001b1345060be6d19b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=talhak2111@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 07 Dec 2023 04:27:32 -0500
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

--0000000000001b1345060be6d19b
Content-Type: text/plain; charset="UTF-8"

Hey all,
I want to build qemu without network devices( nic ), usb and vga. So
basically a very lightweight emulator without the things i need.
Any help and leads would be appreciated.
Yours Truly
Talha

--0000000000001b1345060be6d19b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hey all,</div><div>I want to build qemu without netwo=
rk devices( nic ), usb and vga. So basically a very lightweight emulator wi=
thout the things i need. <br></div><div>Any help and leads would be appreci=
ated.</div><div>Yours Truly</div><div>Talha<br></div></div>

--0000000000001b1345060be6d19b--

