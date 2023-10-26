Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B77507D8326
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 14:48:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvzlv-000294-U7; Thu, 26 Oct 2023 08:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanmaynpatil105@gmail.com>)
 id 1qvxXk-0001rm-3a
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:24:48 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanmaynpatil105@gmail.com>)
 id 1qvxXh-0007sp-8w
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:24:46 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53f9af41444so1173899a12.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698315880; x=1698920680; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vkHIu6joJYEnNxf/Xj9oocJVvBjzyS/BektnDG8mmiU=;
 b=HDwcu2Z/h8UCKdHzrcX0B1Z01ANNpHOmOvZL/ik7yryv3BLA0K8iSYuhBTENhyrF37
 i9Q1u7+2pq9AynYS7zF/zpAIzYDhhHgrS41WrgbbdDxOaBCpumi9XzI2UplhI2UVrYDN
 kNRa5pPfisx4HmHVFoomXgHmEhrCTz0wGk24l0fwuuzQonjfpZZ/uDUy57f9lraAdziH
 +u/4Pw+OHoWRlnvdJWUuto0Y+djeEdndNiw3w7s3/qQSOP0I0KO2vFfLomDKRCRdWNMa
 0JDtoxn+MV3g55BHEU2JUpBm5ACRU18Ug2sm02VESjSVgPMhG1wz/Z+1JKVbGMCUknjl
 S4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698315880; x=1698920680;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vkHIu6joJYEnNxf/Xj9oocJVvBjzyS/BektnDG8mmiU=;
 b=h7VFbWklH+N5VP7gMAtngXAM7ckEOoTtSlQhY0SWBwmh5vm63kwd0ZBBiHHr6ixASV
 oqnqbnPR5jIkp8iHwVcpL7RfgQsl91Dmat0X6/Ft6mLD/D7uo8HTEBMZFqW510FYsJrb
 Xz22s0CGC3eiRi7rANYthZY7+VG+lfzOdoSL8OG4vEr0gft6I6KKtVzcDZWfoJ6bdBI3
 lQXuYfLmYJbAGuiL9nYD/3zuVPifwe2nTyb7HUMYzLNloNRFaYm1BRjjgVspag4AM03K
 Ws1aj2u18JU7ZkbD7CtyJozT8j9MmlEcEpzw3+gPfUGHLZFFlod2q02Rnd03LTXNvyKZ
 ga9w==
X-Gm-Message-State: AOJu0YxgMk6x+tNvJweryZAco/HukWWFAG59jA6uIGE7AjO/7qm6vImz
 VZbUfpOIRlchBNn4aq/Tcnm6Y7VcQ5fivBzQj1Uu1V4sFcU=
X-Google-Smtp-Source: AGHT+IEykMJi6Zo/tCCMNOZwFgQPDVILDpzHZaeUMPw0i0yQmZd8U0hkytpY7IZNgFowtWN7xbwXwSYL4Zk6HdKHGTc=
X-Received: by 2002:a17:907:74a:b0:9c7:4c3e:4267 with SMTP id
 xc10-20020a170907074a00b009c74c3e4267mr13474853ejb.25.1698315880157; Thu, 26
 Oct 2023 03:24:40 -0700 (PDT)
MIME-Version: 1.0
From: Tanmay <tanmaynpatil105@gmail.com>
Date: Thu, 26 Oct 2023 15:54:29 +0530
Message-ID: <CAHnsOnP-8PY=pZw3n2jPKeMmiFqsQwp-Dai+dADpe+hskO2kQA@mail.gmail.com>
Subject: Replace calls to functions named cpu_physical_memory_* with
 address_space_*.
To: qemu-devel@nongnu.org
Cc: "jsnow@redhat.com" <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c0d74306089bfa55"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=tanmaynpatil105@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Oct 2023 08:47:29 -0400
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

--000000000000c0d74306089bfa55
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm really interested in contributing to qemu. I wanted to work on the
renaming API calls cpu_physical_memory_* to address_space_*. I couldn't
find any related issues on the GItlab tracker. Can I work on this issue?

Thanks,
Tanmay Patil

--000000000000c0d74306089bfa55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I&#39;m really interested in contri=
buting to qemu. I wanted to work on the renaming API calls cpu_physical_mem=
ory_* to address_space_*. I couldn&#39;t find any related issues on the GIt=
lab tracker. Can I work on this issue?<br><br>Thanks,<br>Tanmay Patil</div>=
</div>

--000000000000c0d74306089bfa55--

