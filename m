Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 594BC789768
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 16:33:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZuKC-0001X2-Ni; Sat, 26 Aug 2023 10:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qZuKA-0001Wm-Ew
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 10:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qZuK7-0007gR-PB
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 10:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693060293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3ieoz1Is2ci37TNYYbeTL7VRt08TtEL0Kre75lyelg=;
 b=UgYj5askS60Zb0FNcsVFFbRkOI8pzrhO8glDJh5sj/aBOwYEUUCs6FRweVU4sTtCy787S/
 lr9qMRVXAcZolGpis3rTzwRpXYSexQ0jUwDXxtaQmtodZIFtHF1QxVo6tTwtJHp0KHRz/1
 tfGYmyeiLghYB1bfKr3XwKAhLpkQpek=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-ljvVh708OoeLHVGmpK9Frw-1; Sat, 26 Aug 2023 10:31:31 -0400
X-MC-Unique: ljvVh708OoeLHVGmpK9Frw-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-48fd47fe55cso678460e0c.1
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 07:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693060291; x=1693665091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w3ieoz1Is2ci37TNYYbeTL7VRt08TtEL0Kre75lyelg=;
 b=BE7CqHJmgLvfarrs298EuOONDEeCdYRjQI+ks2CqTiVNG0lvy/3unHtgl2P2PwtmuP
 Ry9OYJXR+8ugggUVRoC158KIkzbfDxeVcbZhdf5YwsD1u+FdUyACkqZpMXJCdLFlaUP4
 V8qsal3XMGWXXWwyBMF3FR2RDaUz13U+nMDZqG0PnOtJiB+11gdMdM5stFpoBTHiL6D3
 FZBGuDUd4DvfbdpGQC9zGmysXUAkq8IcPmQOl82HnbuEgl6CO0XbxE6RZGz1s1o2T+XP
 SpW+wSHbo85oQ/Bmf3PrblKPTUM4fJxL0By8PBMKWtL8niqgOdXmMz93cHPJPPWNQKOw
 WLHA==
X-Gm-Message-State: AOJu0YzBmW2HARmI9TnhycHq6Bl3ai2SwlyNY8usyU6P7TULS95txxIV
 dzJhP4SxWZi7/JOoHMDaIFhYsHqpmoyDUom58FMsUbOWXkrbnY2PRFCYesJRe0AW3e8eqK2UZ79
 8l8dtP4E0IRpuyZGm7PAD5gS6PvAQMVDnnhVX58fbow==
X-Received: by 2002:a1f:e783:0:b0:48f:9c75:411c with SMTP id
 e125-20020a1fe783000000b0048f9c75411cmr12060822vkh.6.1693060291269; 
 Sat, 26 Aug 2023 07:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDxhwQCl1SnydSU2vA4WPnKuMoZOf/EfcygoUwLXlMr5d/1otRVecnbmKQQyQ+LFAZrFbvoziTEq/30pSsBTI=
X-Received: by 2002:a1f:e783:0:b0:48f:9c75:411c with SMTP id
 e125-20020a1fe783000000b0048f9c75411cmr12060816vkh.6.1693060291002; Sat, 26
 Aug 2023 07:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220624143912.1234427-1-mcascell@redhat.com>
In-Reply-To: <20220624143912.1234427-1-mcascell@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Sat, 26 Aug 2023 16:31:20 +0200
Message-ID: <CAA8xKjXvhnAyHDH43xcg9_HRqNqf04QhTpcrB2s4ae1d_WWuxw@mail.gmail.com>
Subject: Re: [PATCH] hw/net/rocker: avoid NULL pointer dereference in
 of_dpa_cmd_add_l2_flood
To: qemu-devel@nongnu.org
Cc: jiri@resnulli.us, jasowang@redhat.com, arayz_w@icloud.com
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

On Fri, Jun 24, 2022 at 4:40=E2=80=AFPM Mauro Matteo Cascella
<mcascell@redhat.com> wrote:
>
> rocker_tlv_parse_nested could return early because of no group ids in
> the group_tlvs. In such case tlvs is NULL; tlvs[i + 1] in the next
> for-loop will deref the NULL pointer.

Someone somehow reserved a new CVE for this bug, published a few days
ago here: https://nvd.nist.gov/vuln/detail/CVE-2022-36648.

Not only is this not CVE worthy (rocker code does not fall under the
KVM virtualization use case [1]) but what's most concerning is that it
got a CVSS score of 10 :/

I'm going to dispute this CVE. Hopefully, it will be rejected soon. In
any case, can we get this patch merged?

[1] https://www.qemu.org/docs/master/system/security.html

Thanks,

> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> Reported-by: <arayz_w@icloud.com>
> ---
>  hw/net/rocker/rocker_of_dpa.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.=
c
> index b3b8c5bb6d..1611b79227 100644
> --- a/hw/net/rocker/rocker_of_dpa.c
> +++ b/hw/net/rocker/rocker_of_dpa.c
> @@ -2039,6 +2039,11 @@ static int of_dpa_cmd_add_l2_flood(OfDpa *of_dpa, =
OfDpaGroup *group,
>      rocker_tlv_parse_nested(tlvs, group->l2_flood.group_count,
>                              group_tlvs[ROCKER_TLV_OF_DPA_GROUP_IDS]);
>
> +    if (!tlvs) {
> +        err =3D -ROCKER_EINVAL;
> +        goto err_out;
> +    }
> +
>      for (i =3D 0; i < group->l2_flood.group_count; i++) {
>          group->l2_flood.group_ids[i] =3D rocker_tlv_get_le32(tlvs[i + 1]=
);
>      }
> --
> 2.35.3
>

--
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


