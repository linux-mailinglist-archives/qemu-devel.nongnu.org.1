Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC7D7288FC
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 21:49:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7LcL-0004Lk-2o; Thu, 08 Jun 2023 15:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <williamtsai1111@gmail.com>)
 id 1q7K9L-0004sg-MY
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 14:14:19 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <williamtsai1111@gmail.com>)
 id 1q7K9J-0003qk-Ts
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 14:14:19 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-45ee86a16caso338621e0c.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 11:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686248056; x=1688840056;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=r97IFkJWbQDDdbIa3MNxSnyYo4PmIMNa9SFwK2rgy20=;
 b=OjtBDZhwFA5gC8OGX31PjDBvQo4Wrnt6eDpfolmr3BU47L2KtXtKkja5hOyCEorA4N
 /0FOZBCTRhWX0zcSHeOVBjH+HL47K4llUWeSkHti8JiThnvgzIjkxR3S0IRwQk/eSihl
 0wxgIWv7OXgEHDe77SQtTXXr4g8ofUhPFXYo75PjpJxO9Tc9Pcul19xbbgs1sRWb/Rhi
 jLZjq8P6JwMTV0NwUXOAsdOCZnuplXjBe1NHK5CjzAYPrTV8CGmAIdWJyCMh/AHAbbCa
 xT71UmHYdysBrj6auZMt/FSyxMDPeKLGgtLqpfsmmqb7CiRYNMvERvPMU3vnP/LD4z9y
 HbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686248056; x=1688840056;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r97IFkJWbQDDdbIa3MNxSnyYo4PmIMNa9SFwK2rgy20=;
 b=IjPn1zNCLOms0q3Fp1DcmDenYT4oNgNpnXuMlQnrwQ06GTjrVeW2HkBV0tf99njzjY
 6AB3lUiAYUz+Z35WF39gze3Z0LDfH61/2xfPOgdIL+rHYlz04Eeo2vhBF1wEogbAIioY
 5dDv7TccNLIMTqyN8hGKfQzmFu1eb9VC6FRSPORFoqbABBuOHQcll7T49fzl7prtpskV
 GSyncWF5yQ9Ff+YfpiJ5UOKQITGF0V0VuEXY+R20zivoDa+NeAcGkNNaZZBl6+2JpRNo
 jkbzMgFuoZ+7yXHq0JYFOrDLrCy0VCpQpDawaQzLmKIzzS2AlhGM7s4rxVokhfMUbjgS
 35pg==
X-Gm-Message-State: AC+VfDwuBqSQDxnAOVHVjXoUyfEAMgisbI5mBM8GsFxkgt3liwqag7xl
 6xFmckNrrOmy+OZUXYjcKA6YOFZhHz7LPA4Sa1E=
X-Google-Smtp-Source: ACHHUZ6WS4XgnD2ZXhlNJVqiPc/ZBqSaAI0BjHC+Vd/ieOkk0KQ3utC3JSlO0TTjwlvMPMBvDH5JxxL39pIGTv7+Ox0=
X-Received: by 2002:a1f:eb02:0:b0:464:2bdd:ab1e with SMTP id
 j2-20020a1feb02000000b004642bddab1emr528756vkh.5.1686248056047; Thu, 08 Jun
 2023 11:14:16 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?6JSh5a+M5YWo?= <williamtsai1111@gmail.com>
Date: Fri, 9 Jun 2023 02:13:40 +0800
Message-ID: <CAKJjtLNBhFdrviH-GpzvQH26AsGn6f86CbRj6=18CxkHfGpYVg@mail.gmail.com>
Subject: Re: [PATCH qemu] qdict: Preserve order for iterating qdict elements
To: chuanchan@git.sr.ht
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, 
 =?UTF-8?B?6JSh5a+M5YWo?= <williamtsai1111@gmail.com>, armbru@redhat.com
Content-Type: multipart/alternative; boundary="000000000000624fda05fda238bf"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=williamtsai1111@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Jun 2023 15:48:17 -0400
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

--000000000000624fda05fda238bf
Content-Type: text/plain; charset="UTF-8"

Bumping this thread. Can you help review the patch?

--000000000000624fda05fda238bf
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Bumping this thread. Can you help review the patch?</div>

--000000000000624fda05fda238bf--

