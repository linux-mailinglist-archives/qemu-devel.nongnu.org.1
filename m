Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C7A78C0A7
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qauI3-0004R1-8y; Tue, 29 Aug 2023 04:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qauI2-0004Ql-1M
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qauHv-0004uM-4o
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693298485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oa5YZ9W95kX1RXGN5U9/SC30YBLVsNjdlGkYKzS2mDM=;
 b=cNYc03p3Vdji21d4d3MItctAvsNlnEgN91/lf7H334eJc2BmhqK49nxrn5HKEKuSzuY0WO
 tsSZUQC0K9SYhIujVp43QK6/MsnVuHk+lUW+2Tv4q7zINWnJpxPW/FtE2x/tUUhph9NhtY
 u79kfgMI5ojEPV/Bde0UwcltIL2t+So=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-96KEHUgqP-qHOi0iJ8uNcQ-1; Tue, 29 Aug 2023 04:41:22 -0400
X-MC-Unique: 96KEHUgqP-qHOi0iJ8uNcQ-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7a2627791d4so1260286241.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693298482; x=1693903282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oa5YZ9W95kX1RXGN5U9/SC30YBLVsNjdlGkYKzS2mDM=;
 b=OmScQkkglmwFy3R2yFsJt1Bq5j3Xq8DtqMdJZFd7CkTtXhUA6opWT1K25EvaV7oYNj
 jpkrtxdu9LyhrWdTPNNrepr82O9eRachMh3V0zye2pLTOlDBj4no+7KpZt/s/cOGzcWw
 yw4SnQwGCZ9FeGK1ToU/EDZtxeR674ykLD3oogmj++28A+kdpPWE7F6Igv+gVbrGdLCv
 kPh3+yifVSFKgk6n9yW+a0jKBvzLlfgwNhxgLEDqFLe2jrdw3vXHf3WhdujHg4Q3wYbW
 6sG6a/D6j7CIvDCCt1ETzNdrm08tT4kFT9zLWc/uGBV7X+6JoyEP6KO2Lz1kBED5x6Zj
 wlXw==
X-Gm-Message-State: AOJu0YxcDMpXYfyDsC7KRoT6TLoKkVoa+VSjdYKxkTpPe56X+Jdv44qW
 Ju/+DuEo2a3DY8g0lvHbV5lNVMKjAH8PKOi/M6h5nNVF1vqiyp1d6hDw9dZT8WmunxOSyQOpW0/
 N0XVi/Kn2FS4OvY9yyw6/vzoXt3ht27c=
X-Received: by 2002:a05:6102:e41:b0:44e:9709:c11a with SMTP id
 p1-20020a0561020e4100b0044e9709c11amr9431273vst.14.1693298482278; 
 Tue, 29 Aug 2023 01:41:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqnT+WkCyxi23qvW2OXK2GFm8pHZSYVasM5vlgpr6B+dAa4l7tdZ57gC0L3gVdG6B60RBVo8QILbft7dtNukY=
X-Received: by 2002:a05:6102:e41:b0:44e:9709:c11a with SMTP id
 p1-20020a0561020e4100b0044e9709c11amr9431268vst.14.1693298482021; Tue, 29 Aug
 2023 01:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220624143912.1234427-1-mcascell@redhat.com>
 <CAA8xKjXvhnAyHDH43xcg9_HRqNqf04QhTpcrB2s4ae1d_WWuxw@mail.gmail.com>
 <CAA8xKjVyqbJrkdL-DF0=DsDWFKOkJqqwUa-5kAyn8n+qp2u8iQ@mail.gmail.com>
 <ef6a2f21-ebc2-44ae-ea5f-04f960c6d756@linaro.org>
In-Reply-To: <ef6a2f21-ebc2-44ae-ea5f-04f960c6d756@linaro.org>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Tue, 29 Aug 2023 10:41:11 +0200
Message-ID: <CAA8xKjURXhOp=XQjmxf-uO4K8_N_SCmX-mU_jq=L=u+sg9+sAQ@mail.gmail.com>
Subject: Re: [PATCH] hw/net/rocker: avoid NULL pointer dereference in
 of_dpa_cmd_add_l2_flood
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, jiri@resnulli.us, jasowang@redhat.com, 
 arayz_w@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 28, 2023 at 6:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 27/8/23 13:07, Mauro Matteo Cascella wrote:
> > On Sat, Aug 26, 2023 at 4:31=E2=80=AFPM Mauro Matteo Cascella
> > <mcascell@redhat.com> wrote:
> >>
> >> On Fri, Jun 24, 2022 at 4:40=E2=80=AFPM Mauro Matteo Cascella
> >> <mcascell@redhat.com> wrote:
> >>>
> >>> rocker_tlv_parse_nested could return early because of no group ids in
> >>> the group_tlvs. In such case tlvs is NULL; tlvs[i + 1] in the next
> >>> for-loop will deref the NULL pointer.
> >
> > Looking at the code once again, tlvs is a pointer to a g_new0
> > allocated memory, so I don't know how it can be NULL after
> > rocker_tlv_parse_nested (unless g_new0 returns NULL in the first
> > place). I do not recall the details of this bug. Arayz?
>
> Per <glib.h>:
>
>    If any call to allocate memory using functions g_new(), g_new0(),
>    g_renew(), g_malloc(), g_malloc0(), g_malloc0_n(), g_realloc(), and
>    g_realloc_n() fails, the application is terminated. This also means
>    that there is no need to check if the call succeeded. On the other
>    hand, g_try_...() family of functions returns NULL on failure that
>    can be used as a check for unsuccessful memory allocation. The
>    application is not terminated in this case.
>
>
> group->l2_flood.group_count is a uint16_t, so up to UINT16_MAX =3D 0xffff=
.
>
> So:
>
>    tlvs =3D g_new0(RockerTlv *, group->l2_flood.group_count + 1);
>
> is at most an malloc(0x10000 * sizeof(void *)) =3D 0x80000 =3D 512 KiB.
>
> QEMU use way bigger heap allocations.
>
> I don't know the net/ subsystem enough to have an idea about how many
> concurrent packets can be processed by this device model, but I'd be
> surprised if this triggers a OOM.
>
> As usual, do you have a reproducer?

I just found the original bug report and opened a new issue upstream.
See https://gitlab.com/qemu-project/qemu/-/issues/1851.

> >> Someone somehow reserved a new CVE for this bug, published a few days
> >> ago here: https://nvd.nist.gov/vuln/detail/CVE-2022-36648.
> >>
> >> Not only is this not CVE worthy (rocker code does not fall under the
> >> KVM virtualization use case [1]) but what's most concerning is that it
> >> got a CVSS score of 10 :/
> >>
> >> I'm going to dispute this CVE. Hopefully, it will be rejected soon. In
> >> any case, can we get this patch merged?
> >>
> >> [1] https://www.qemu.org/docs/master/system/security.html
> >>
> >> Thanks,
> >>
> >>> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> >>> Reported-by: <arayz_w@icloud.com>
> >>> ---
> >>>   hw/net/rocker/rocker_of_dpa.c | 5 +++++
> >>>   1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_=
dpa.c
> >>> index b3b8c5bb6d..1611b79227 100644
> >>> --- a/hw/net/rocker/rocker_of_dpa.c
> >>> +++ b/hw/net/rocker/rocker_of_dpa.c
> >>> @@ -2039,6 +2039,11 @@ static int of_dpa_cmd_add_l2_flood(OfDpa *of_d=
pa, OfDpaGroup *group,
> >>>       rocker_tlv_parse_nested(tlvs, group->l2_flood.group_count,
> >>>                               group_tlvs[ROCKER_TLV_OF_DPA_GROUP_IDS]=
);
> >>>
> >>> +    if (!tlvs) {
> >>> +        err =3D -ROCKER_EINVAL;
> >>> +        goto err_out;
> >>> +    }
> >>> +
> >>>       for (i =3D 0; i < group->l2_flood.group_count; i++) {
> >>>           group->l2_flood.group_ids[i] =3D rocker_tlv_get_le32(tlvs[i=
 + 1]);
> >>>       }
> >>> --
> >>> 2.35.3
> >>>
> >>
> >
>

--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


