Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 373EF7574A9
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 08:54:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLeZA-0004qT-R0; Tue, 18 Jul 2023 02:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpitha.14n@gmail.com>)
 id 1qLeZ8-0004qL-Vi
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 02:52:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arpitha.14n@gmail.com>)
 id 1qLeZ7-0003pF-HZ
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 02:52:10 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso55209685e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 23:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689663127; x=1692255127;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jGZVIwFACrgkMdv8Pl8FMmRHa3LIbktK8P+8g/baHUs=;
 b=gAL+trGRFwa19Cp6/D2/rlf/LzOyAkkrGiLe2z930lZdRIo+SMC7V07yhB2q/vMB6Y
 JBA+sVPBeOEMxFD6ev/dUXTUIT48gz4vqCscdw0+TsNSV0Q2un4H/mjevT8PWsku6K1b
 7K/KdnFiRgLpL4HX3xerkAl5ZhQ7Jyw/s+VQ9eAPS6yrXoSZCEWIsYj9jk1jFM3mcCAu
 VEAxjqQcF0hU1rAVlrf7FyosRot4oQH5jD5KxuRJezuysEYObydm5GAMsfekg2/IK3y4
 AAThamFZvDb3DO1z1EGpkDdm03bZvPd4CCDI03ceCmXAswT8jl1WCv7dTOCSfBZW9Xgr
 HmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689663127; x=1692255127;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jGZVIwFACrgkMdv8Pl8FMmRHa3LIbktK8P+8g/baHUs=;
 b=BCsw/kzslEZTLosrHBoX0rD9XOjYh94Nl4LILM4ymy4JHfhFYt8w3NGP5kDF35WYKY
 U6Tb5f5bJgLxsp6HELIblm5c++zfOL7xQkumwnaZeafXiuDJYQSDMCtvTLrI0C/83dGZ
 16O+RFkZ2f50FGre/hzrqYaSn9TOzMx2rh7VWxvN+HgY7Ou3SLWCse9HC0tK9IpoB9hJ
 ElUgZngrfHoQODKiG/Y/1/GaK4UaZ9DaOFZVqShCO0aaF/efJpAUkZdbMu1jN//vEOeS
 9u47tIKd5ljzgeneU1QXL6nB5d1LmySaxc4YdEqx7diWkq4CbH0gByKuSxKEaQ3Ha61m
 N0Og==
X-Gm-Message-State: ABy/qLZbGKXx6jaiB43/NPebg5XocK3BmTikItTn2qdvc3l4Dq3WH6qw
 v6T7vBAz+zeVlTbF11gWXiR5oLRuGSv92Lub3Ed3KXPt
X-Google-Smtp-Source: APBJJlFTS111ojodqWSEJq7mmPbnWo1fGZ/i5KgIsQQemcGlPJKwHdMSSXnCJr326UpcHESyRAbG4t60StLEuJkr6zQ=
X-Received: by 2002:a5d:456e:0:b0:313:eb34:b23e with SMTP id
 a14-20020a5d456e000000b00313eb34b23emr13855041wrc.49.1689663126566; Mon, 17
 Jul 2023 23:52:06 -0700 (PDT)
MIME-Version: 1.0
From: Arpitha N <arpitha.14n@gmail.com>
Date: Tue, 18 Jul 2023 12:21:55 +0530
Message-ID: <CAAr8dKk353n2CXkvYSxC6JA-hJNZCjYMr0H7L+Tjjz0UapPdhw@mail.gmail.com>
Subject: Adding fuse compare and write
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000072f9940600bd5a80"
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=arpitha.14n@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_05=-0.5, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000072f9940600bd5a80
Content-Type: text/plain; charset="UTF-8"

help :

I want a patch for adding fuse compare and write in *nvme*

--00000000000072f9940600bd5a80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">help :=C2=A0=C2=A0<div><br></div><div>I want a patch for a=
dding fuse compare=C2=A0and write in <b><u>nvme</u></b></div></div>

--00000000000072f9940600bd5a80--

