Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C513870455E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 08:37:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyoI6-0008WQ-L1; Tue, 16 May 2023 02:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ido.ber3@gmail.com>)
 id 1pyoHy-0008W3-Kn
 for qemu-devel@nongnu.org; Tue, 16 May 2023 02:36:02 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ido.ber3@gmail.com>)
 id 1pyoHx-0005Li-6D
 for qemu-devel@nongnu.org; Tue, 16 May 2023 02:36:02 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-61a4e03ccbcso125504156d6.2
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 23:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684218959; x=1686810959;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8wSNuSWeOeQxf5AGF5p5Udu/O+IkUpM00cP1QJGtduE=;
 b=TmJqHT6qFPVvHk9qQG8BKeDnHB4kPY4mKgXv6WiV9kLs9p2VL1zqej7ZGl38WskPbv
 6GzJ9pt7/DeD9a3cNtaQ5JmDiNtwtM5nFzpLmrDMYgBrXsehd5V79kh61OT9Sah0mj4a
 7UbXGuFe/IonVVMMiZwrw96oV973MvDpy/VX8Ju3YN/LDdLlpSnndKWRUIUPWR2YeX9g
 kfzXm2z/2JVvmFM0jG68adS95XQd1ist5qIQG1a+9SgWuWHZDnBFZnEkWxWnWd1iKuCd
 WXWxmFoh0W9f3uuvY2z3Hhgo0ANd7Kvq+015BWDPjqGeuGtZDA/56bCrW1kF1ZFRERlv
 N1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684218959; x=1686810959;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8wSNuSWeOeQxf5AGF5p5Udu/O+IkUpM00cP1QJGtduE=;
 b=M+EQMQHLNqAJiUn+g+0avnjdyww/XtBfp8xOmheXQmKXu+uNh5e5+tZwtIbPej1g9v
 hDX7y9sxpIgHbXlE/tAUFBeo0gGdmdZDQkrJfcdwwT13QwODmlweRl5EhBxtlGvX90Hw
 sDGWUHTqQbuIr/nhubhfwwxEueokh3I4BHTEBvTfyZKdbOfCOD/lY2+X+TfuWYvHcZAv
 3jfTvNjS7H18p4lNL8jslfw28MgEfUXwc38PJDGelEB4cs7DRJUqV62JzS3ElloDCcuO
 ega5cu46cMo3wNIH8SAKLbI3uvxzcpp5I9WhZBaXVz4qMrAXlgOLrLJALjeyr5F/VbbO
 TnTA==
X-Gm-Message-State: AC+VfDxgNiyZF13pZ2b9gonnn5CbeuXXR7ARLq6/KiBNIGX61q2vjyC4
 eG+NsjP2NXwbNLXNrw/5e23W/L0xYLrJo2oyjuEDvE/OXSc=
X-Google-Smtp-Source: ACHHUZ4+SZ+eydcTv8SWIkc3gP0+pgS5jGSPyoHgbslSLV4x41SfMGbTRKLf7ShP07El6cMsO0JrH3Wd3r4zqyYT92w=
X-Received: by 2002:a05:6214:e6d:b0:623:7483:23ee with SMTP id
 jz13-20020a0562140e6d00b00623748323eemr3787368qvb.18.1684218959431; Mon, 15
 May 2023 23:35:59 -0700 (PDT)
MIME-Version: 1.0
From: ido berenbaum <ido.ber3@gmail.com>
Date: Mon, 15 May 2023 18:17:14 +0300
Message-ID: <CANamGFG1Lq+QSMshgYChj663K=Sj19YEh8WP=HWYM6HBnpRpWw@mail.gmail.com>
Subject: Gpio in vexpress
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000cd0c3605fbc9c8f0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=ido.ber3@gmail.com; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--000000000000cd0c3605fbc9c8f0
Content-Type: text/plain; charset="UTF-8"

Hi, I was trying to understand the architecture of the vexpress virtual
machine in regards to adding new gpios that are going to be external.
First, is it right to act as if I am developing on a physical board and add
the gpios to the VexpressMachineState struct?
Secondly, which gpio type fits here? I see that for fsl_imx7 it is the
imx_gpio, but what is for vexpress? Should I create one?
Or, can I use pl061?

--000000000000cd0c3605fbc9c8f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi, I was trying to understand the architecture of the ve=
xpress virtual machine in regards to adding new gpios that are going to be =
external.<div dir=3D"auto">First, is it right to act as if I am developing =
on a physical board and add the gpios to the VexpressMachineState struct?</=
div><div dir=3D"auto">Secondly, which gpio type fits here? I see that for f=
sl_imx7 it is the imx_gpio, but what is for vexpress? Should I create one?<=
/div><div dir=3D"auto">Or, can I use pl061?</div></div>

--000000000000cd0c3605fbc9c8f0--

