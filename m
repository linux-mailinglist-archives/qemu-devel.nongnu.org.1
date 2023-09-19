Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 917CF7A6A5F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 20:01:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qif07-0005Ln-K7; Tue, 19 Sep 2023 13:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1qif01-0005KI-3S
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:59:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1qiezO-00017l-Ii
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:59:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4009fdc224dso9165e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695146294; x=1695751094; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sh5xh2e7bs6SumT4MbG/jJKUyxEtpyvDJseve3g3Xqk=;
 b=gy9UBLZRxTw80YhG7VIKHncUSHqtq5VZ490qklsyCi5NqmObjRsmcMHIyh9nFhw98l
 zbUctGJB58bLEyag6GiHO0ld8qIe5FLHMiMdwUy+FwZkL+tcI4z10h6orIB/6lx0Yex+
 VxMDE8xL9mejOOEhVPp8zewTilWkWCOAUJy8+PcgZIOaJc30cF+rhdOGr7Eqf+G7XVeV
 nFgdh0Lbi8sWoOWYb7uNn1n+YSayZAGN5uxEMlW2oe7kF4UD2e7ltSCakBlF+l8rBTLo
 sCHBeyHhZZ7z+hQDbN6bHXiMSmoasagfLWDMu8V96EF7VEic6HhIs+4Y+KLL359WVz1j
 QeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146294; x=1695751094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sh5xh2e7bs6SumT4MbG/jJKUyxEtpyvDJseve3g3Xqk=;
 b=BWKGNFS26Ppr9zIxLbsX64Cf9BlleRnZZ0ZMGzcSUS+gYT3KK1WiwsnBm+tdmk3f1I
 +sSdVYTT/kNAMYXJUo9HWGTJEr2vslkeL6Nr+nug0uDMFJ239GrB9v+HjUxQLgpZXYC5
 kt5DoHcQoby0ZjRe6qqqtF5mLXKx38fCYg690tW6W1ETpSamUvGc5AvdfI17XslPIvrR
 /gS4LidoWcs9zUMGVpcjctL41xoeJGccpC17fM9BFhVsg3oegcslPWiN1adDSsEUyvXg
 A8zx/wCWNZvUDk2yv4m6goAfz07MlE+weGLAkmJvyM1kmaMEVFATMgfX2XvKcnmyjeoI
 nwew==
X-Gm-Message-State: AOJu0Yxf3N6bopvYcaJB/vAKd2iwEcX5Fs1YTHdzQhO3UPSWGz3GtlDL
 N1Sv1tUNUJHxXCQ++9NNldrUrJmjl2ZyszyI5bQtrg==
X-Google-Smtp-Source: AGHT+IHG6cUN9K1FZa/Oh6T+oNJL/Ofl7F+k/tNOaV08hGSpfXwCOqHYUwOddLVkT9/uKosltCD4qiPXOMlQY/ZGV80=
X-Received: by 2002:a05:600c:1d09:b0:3fe:f32f:c57f with SMTP id
 l9-20020a05600c1d0900b003fef32fc57fmr9280wms.0.1695146294094; Tue, 19 Sep
 2023 10:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230919174200.GA1542425@fedora>
In-Reply-To: <20230919174200.GA1542425@fedora>
From: Hao Wu <wuhaotsh@google.com>
Date: Tue, 19 Sep 2023 10:58:03 -0700
Message-ID: <CAGcCb129WnfjYqP-mi2j0wo2LT76ATj4yVS3rw+WMEek3R-aeg@mail.gmail.com>
Subject: Re: npcm7xx_timer-test.c is unreliable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b3f9f50605ba00ac"
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=wuhaotsh@google.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000b3f9f50605ba00ac
Content-Type: text/plain; charset="UTF-8"

>
> Let me take a look at that. I suspect the timer is off by 1 tick due to
> some rounding errors.

--000000000000b3f9f50605ba00ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Let me take a look at that. I suspect the timer is off b=
y 1 tick due to some rounding errors.</blockquote></div></div>

--000000000000b3f9f50605ba00ac--

