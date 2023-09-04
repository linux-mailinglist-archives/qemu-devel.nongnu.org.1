Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3D179163B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:29:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd7kq-0002Bx-MU; Mon, 04 Sep 2023 07:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd7kn-0002Bj-Li
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:28:25 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd7kl-0002EL-EI
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:28:25 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-41206fd9717so8859841cf.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 04:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693826900; x=1694431700; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELjcYFo3MpcUebgSkfjXky82B2a7iLTfY3p6mxAt/sY=;
 b=FEYFFWISjUn/9y5jeDdROJbnhbR149bNtrs/E1LkoaDGxQ95VevpzKgHeZETqRzLy5
 4lCX8haKudh3+s5w6pCO+8SSBHR9g1dVmKgYKryDFnGVKgV+IuqKiJqtKZdAj0PT2DnK
 YNetSOlqNiZfTrKIhFoefB9BktERID6yvQE+mBYNocNcNmpBjAG4lHDMR2YoWImHXWLd
 mUe0YYON+SCDsGuOAiOiL+l7bVf4tLv2+NyhmN9T7qSEr9ooZ4mzOquRBfk1FAE4pgc3
 ksBqu0JO1pnUJnJtaOqWTk08cGqk7Ri4SmAxJU/W4L5IU2jdC9CL81/Ttb3caebTmGV6
 F6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693826900; x=1694431700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELjcYFo3MpcUebgSkfjXky82B2a7iLTfY3p6mxAt/sY=;
 b=F/PqNDB1OFyPif5tF0jNqlJpJdC8kc9TvFNHDIfNclzc4uIx9ptd5zKg6UWfrtlK2N
 Dn2lUu0GIFPS8CDsyjKwrKf0seohiHwGlR+aYAl3Eq9S1Dq2NDwgUs/+MmO6aZbGa19D
 5QYyUTk6S/Bg7VhtDvGdvYe2UBANukvRPEfBia6613/ZX9JYJBDIuNoanPA/2b7Wtp7l
 ykbn8G8nH1rrS5oXB0jRNnYaGjn0l43OFD2lCoAK8CcQHCxjz/AQAn8F8Dp/zpD8nuyO
 StfPZT+gOBB3uKJ1xhDEhN2F6IFwajhNl3YfK2isIDRTL+XVTtPsUJ0L1RW+muRbZk2l
 UAtw==
X-Gm-Message-State: AOJu0YygGVC0TTrG+hRJ4q1OeBtyuD35rHUtxNku2xWj2kC8HVPexXa2
 XXr7xZG0hVXzSxZBtzVzz06G84p+Tncfa+NN7zY=
X-Google-Smtp-Source: AGHT+IFVaq94zUUW6qMwJCdq81JgNxyJ0K/jK/5IDN5VbJ1KRMkK3qzfmty0V6JKG6DLBciAvSAF/tZWZiKcmkpEni8=
X-Received: by 2002:ac8:4e86:0:b0:406:948b:1b29 with SMTP id
 6-20020ac84e86000000b00406948b1b29mr13017023qtp.17.1693826900500; Mon, 04 Sep
 2023 04:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692281173.git.tugy@chinatelecom.cn>
 <53c35332-cd31-4814-ae7d-19520d749420@chinatelecom.cn>
In-Reply-To: <53c35332-cd31-4814-ae7d-19520d749420@chinatelecom.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Sep 2023 15:28:09 +0400
Message-ID: <CAJ+F1C+7JQEfiT8C7wHYnDZXD_6LB13+_CeYAeFB+4kShb2gkA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] ui/vdagent: Fix two bugs about disconnect event
 handling
To: Guoyi Tu <tugy@chinatelecom.cn>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, dengpc12@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Mon, Sep 4, 2023 at 3:26=E2=80=AFPM Guoyi Tu <tugy@chinatelecom.cn> wrot=
e:
>
> Hi Gerd, what do you think of these two patches? Can they be merged into
> the upstream?

I'll queue them.

thanks



--=20
Marc-Andr=C3=A9 Lureau

