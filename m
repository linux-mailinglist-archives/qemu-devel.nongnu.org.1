Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E201A823613
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 21:06:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL7Ty-0003wF-Ml; Wed, 03 Jan 2024 15:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rL7Tw-0003w7-PF
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:04:53 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rL7Tu-0000ne-Kf
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:04:52 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a28ac851523so84096466b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 12:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704312283; x=1704917083; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XotvJpbWf+FY0z5QuEPNQxlfTIz1FqaIq8h0N/lBN8=;
 b=XZHRNcg6SoRmVrKPZVRoHzbMQGWa5AbE/NYn2TNAdderTUDCwkYndeycikM8SQ+w2+
 im5/5STEIS24PN6D6y0SkbHZxp+hmW46ayNERmSclERqjjIlRkZ9fCRs6esN8XzgXmuZ
 QuhbVE3t85uUn7mw8iwk3dgafj8TMm+/5iWSrcXULEyA9r5hYFxq1O/Ukhb/rK0JOcbN
 wimkpPpjkrYVxS2eQ05nXwQRk3x+MWRoFWF4ffIgLM7JTGLVP6jpbNuRhaSN31KjdRWq
 VrTH65uYLwaOlltpvEzLYVSWMPAD8pJ4wQf0cAQnzNMRonNAkghPJk0kyNAJyl5rLIRB
 pF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704312283; x=1704917083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XotvJpbWf+FY0z5QuEPNQxlfTIz1FqaIq8h0N/lBN8=;
 b=PijO5WqdLfzs/VmWMkJPeF2xwl1zxQQJmRpeLmPCxaTpv/DVPMTDJrLSEcO0CWoadd
 TWxdQWXN+kYayBgzNZIikHvfWoMCWOHH7PpgYvMSY5ji5/LgCYq6CW33BWW3wRrHPwyr
 YB2zqJVaVM6D6mi7crTmOrihn/n2DjjC3Jdfe90X7fi21WQfJtzWBTI3ycZ51dobuTCB
 bq9zTSahetfrPQb/c2vbkRjAyWN4Bnip6/Bm1EYnokRTbPsS0Abz+X/Q5ieeuhaQg5kn
 0R2kUn1BdoDB+Ggvctr6xBoVzBHYkwvRMVMyCGO1DCKXavMttxCG70qXXp+YxpizRrE0
 I66g==
X-Gm-Message-State: AOJu0YzJiah8FIa72gllmpseOcmSvpLysrpyMlUHE+ovyACmSZUvjCcL
 44BUFI7JFv/c4nMpDDuX3iVs7aUx5uEKf4PhMHWnIXj2plyNCw==
X-Google-Smtp-Source: AGHT+IER3twzYaH92tiTo7Uz/fZ5/qBWDisUDWmD4HbpGnUdWDMgX9KD/FM+Ws9Ak3gqpHwKj5Wf7mt1isU2W/s5/GQ=
X-Received: by 2002:a17:906:4e4a:b0:a28:a8cb:3185 with SMTP id
 g10-20020a1709064e4a00b00a28a8cb3185mr617825ejw.69.1704312283040; Wed, 03 Jan
 2024 12:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-19-hao.xiang@bytedance.com> <87o7eu80tu.fsf@suse.de>
In-Reply-To: <87o7eu80tu.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Wed, 3 Jan 2024 12:04:31 -0800
Message-ID: <CAAYibXiChYSjaHmi22xJ7s7dpQ6X4s22dJ3SzL2M0zkVrTNeNg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 18/20] migration/multifd: Enable set
 packet size migration option.
To: Fabiano Rosas <farosas@suse.de>
Cc: peter.maydell@linaro.org, quintela@redhat.com, peterx@redhat.com, 
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Dec 13, 2023 at 9:33=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > During live migration, if the latency between sender and receiver
> > is high but bandwidth is high (a long and fat pipe), using a bigger
> > packet size can help reduce migration total time. In addition, Intel
> > DSA offloading performs better with a large batch task. Providing an
> > option to set the packet size is useful for performance tuning.
> >
> > Set the option:
> > migrate_set_parameter multifd-packet-size 512
>
> This should continue being bytes, we just needed to have code enforcing
> it to be a multiple of page size at migrate_params_check().
>

OK. I switched back to use bytes and enforced multiple of page size at
migrate_params_check().

