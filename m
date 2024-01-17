Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A1C830936
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:09:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7X0-0001WL-Su; Wed, 17 Jan 2024 10:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ7Wz-0001W2-Hf
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:08:41 -0500
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ7Wx-0004ja-VN
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:08:41 -0500
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7bef44df5c6so198211639f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705504118; x=1706108918; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MLtWV8g0MVy/3/wUSbe0dTtdZqd9KVaYX0xbV1Rvt4c=;
 b=DMv4DtL0wJ6f1XtxAsdznFXniMmNm4IBBLJOcO3mADAv8DyYow/WnUfyWvtmpT3REl
 fC/kTep/kji56gI1+p83NgeOGJTL47JHh04DYxdiKG27kF4nCj8gBfpbsEeR62SLusf1
 JZBuLUKTmclVi3hjKYjt95x+UYO2sEE6yEU1aCLz81PBODk2VeGaBf0/tz2T4TdHOumJ
 DBUbUb5MfJFzD+hYj0QqCWvUdiaq08/Xg5FE8NdTWCADohIsUR/tiQHdD+92D6t68QW1
 gkPCGyWJGdSLjQxD7DgwirqmwmymQyli/PYQ17geoP7bBZVrHj9e13gWJPJ0SSf2Rrcd
 0mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504118; x=1706108918;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MLtWV8g0MVy/3/wUSbe0dTtdZqd9KVaYX0xbV1Rvt4c=;
 b=TMNdHtF8+BVm2GVohGhTrrLr8i27lzSBSX+w0R1wRUwbMy1EbT/mRhrK9TFH6vp4vT
 1uTjCKRSUffUs59PKDgn1KkHgxYqxnScv0WX7Xobc/vkB4+UNzVgLJ8OdhGrcC4W5s3D
 L8FtDsPnWMxTOpXzeWjwClsH2Nk1YCLqyAqU+rZLa1j1pEOnQSHjd1soaWYmhzzMuI+q
 LiREZ0J88eHuwc8IWFdyI0C8j6iPAsK/f5aiXgSP1nxMaKyv2RfIZIGlMQXmO2tdo/hl
 bHRnT5HpIksVCtl6UrkXjhjOqTKphxTl+GWgR240sLAFXN0dqH600iYhjvAmcopIRMhQ
 rHSQ==
X-Gm-Message-State: AOJu0Yz9LPRNOXZ5D4UgT31xR7WGNfTey5y53R4Gp4cdMd9xnItChimu
 no+fesUG7384Ss5eqHYUztUcB5KOpDxoyy8sbyHWM88q
X-Google-Smtp-Source: AGHT+IFvILs4uTzzMBJZgrmdi+YoejqXJ/RN+Sz+xagLB3v4eTHaiAjkOp3FWirvi+OVRJDTtjNzKMW9u15HNErHD+s=
X-Received: by 2002:a92:d785:0:b0:361:90ee:8f72 with SMTP id
 d5-20020a92d785000000b0036190ee8f72mr619080iln.27.1705504118723; Wed, 17 Jan
 2024 07:08:38 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mkL6EzLgRvYZ2gp=dmF_5gxD-9cJBTODAb8UtjurZuBKg@mail.gmail.com>
 <37ef47fc-92a5-4ffe-9677-2bc013cfe20b@linaro.org>
 <CAHP40mkNb5EH_Js02LpENMc2CA2pj7fEJY_S1sTMNWh_3rcUEQ@mail.gmail.com>
 <20240117143306.lnycf2ijwkzycowj@begin>
 <CAHP40mkk4aRG+9PGjoW2U38WXSvd1NpvDgMet4AQASg3=H=UdA@mail.gmail.com>
 <20240117150323.xn5otaf2ovg3hyp5@begin>
In-Reply-To: <20240117150323.xn5otaf2ovg3hyp5@begin>
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Wed, 17 Jan 2024 16:08:34 +0100
Message-ID: <CAHP40mmG_SxUqhwysVzYt-c+UF5YVNqk2fBTZpHzAhLn7BCijw@mail.gmail.com>
Subject: Re: [PATCH 2/4] Avoid multiple definitions of copy_file_range
To: Manolo de Medici <manolodemedici@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, bug-hurd@gnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=manolodemedici@gmail.com; helo=mail-io1-xd2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Understood, but I cannot judge if it is a bug in qemu or it fixes
another host os,
since qemu doesn't target only glibc.

In order to avoid breaking other hosts, I consider it more cautious to
ignore the difference.
In the long term the Hurd is going to implement copy_file_range

