Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B43D280E2D3
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 04:36:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCtYi-00026U-K3; Mon, 11 Dec 2023 22:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rCtYT-000230-Dc
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 22:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rCtYO-0007ZQ-RH
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 22:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702352126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whmiOMS/XO53RRh1kbtsb/AXWvE68Za07sUW5whEtHI=;
 b=C5qbJF2+HjRmWahAzbwm+c/RsCBUV6/uNatxol0ONfEvJCO/Yd+3jvKT6j45mvuKf8hwYR
 NN1y+aAedGLOUVqHfXJahVWuUtHmNogOF5oc1TQGCDs58SdLAtsUOFecHOBS+/SJz43H5g
 rE46MA7KfitlWwgzBCefGmn4xwODg6U=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-f4tJgkd4PnarYGK-UYHvKg-1; Mon, 11 Dec 2023 22:35:24 -0500
X-MC-Unique: f4tJgkd4PnarYGK-UYHvKg-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6ce6fa748c5so6136566b3a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 19:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702352124; x=1702956924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whmiOMS/XO53RRh1kbtsb/AXWvE68Za07sUW5whEtHI=;
 b=X6AHrab/rbehwe6OGT9jMBRotfle1/Be430WtNaZY0UNbi/11Dw2CxsUwtk8qtlR1W
 JSCsIMO0gW8CB3sq/WxWHVh72NqEfQJRwjRMH/q17f594C9ROVnoZSw9AyRAFnTcS5dJ
 JRu3i0+4m78Zioj99CVUiKznjy6hn8pwC8uOUDojZ9hq8XKwTw0MOWU1VatnNb3GXV4A
 7Xbcu8rO3iFwRevMNuOmM9SFqvpEXgz7vjzLyXIdMzrEJr/TgwbRsXYbYwD+ebL2U4GY
 eGNVElJllTdgXpNPGAEX3HwVyYCeTj90PmP2vNTw2Jqy8z5E0yyRr21OYb4Yq2ICUuT4
 wLfg==
X-Gm-Message-State: AOJu0YyKbgDfXopJSnC87zopi/sVCIB/h4We9t6NlqmsB6UE2ycmxvh5
 0VzLviYjIgCL0nA7EdWotSkO6E1n560AWAAwyKVskxnFU8RBslLtgWFNuwmJoj3OGXv+xR5lco3
 mR8kJeyjmWk5kTasnig56s8WGg3DaeIU=
X-Received: by 2002:a62:5ec6:0:b0:6ce:3835:812c with SMTP id
 s189-20020a625ec6000000b006ce3835812cmr4966031pfb.65.1702352123722; 
 Mon, 11 Dec 2023 19:35:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG96HL6WKIVBcTJiTDjOwRNwu1gspAYeb/7bl03SGZ47IThjotSsLKhzz+INRgMnargMSeWkv5Anct0fkCJ7ZQ=
X-Received: by 2002:a62:5ec6:0:b0:6ce:3835:812c with SMTP id
 s189-20020a625ec6000000b006ce3835812cmr4966018pfb.65.1702352123332; Mon, 11
 Dec 2023 19:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-2-andrew@daynix.com>
 <46697e3b-3ec4-4635-97d5-39919068d709@gmail.com>
 <CAOEp5Od+_KHm86L7PLVo22KqLZuBc4dWjh0=4iAvT_zyhSRLMw@mail.gmail.com>
 <47d40dd5-3a75-4f54-91b7-2f9b073597fe@gmail.com>
In-Reply-To: <47d40dd5-3a75-4f54-91b7-2f9b073597fe@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Dec 2023 11:35:12 +0800
Message-ID: <CACGkMEsHaOgVotR-fSh2FgObM5c2ey4keyQrR+hE_Kuw0UwyZg@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] ebpf: Added eBPF map update through mmap.
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, mst@redhat.com, 
 armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, 
 berrange@redhat.com, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Dec 11, 2023 at 10:07=E2=80=AFPM Akihiko Odaki <akihiko.odaki@gmail=
.com> wrote:
>
> On 2023/12/11 22:48, Yuri Benditovich wrote:
> > Akihiko,
> > This series was already discussed several months ago.
> > I'd suggest to postpone commenting on it and resume them after merging.
>
> I found a pull request:
> https://lore.kernel.org/all/20230908064507.14596-14-jasowang@redhat.com/
>
> Strangely patches from that series seem missed although earlier patches
> are on the tree. Jason, can you tell what's going on?

It should be my bad. eBPF RSS series were in V1 of the PULL request
but missed accidentally in V2.


>
> In any case, I wrote comments to the patch series. Andrew, can you check
> them? They are mostly nitpicks, but I think you may have a look at
> DEFINE_PROP_ARRAY(); it may make it easier to implement the libvirt side.
>
> I also forgot to say that properties should not have underscores;
> ebpf_rss_fds should be ebpf-rss-fds. See:
> https://gitlab.com/qemu-project/qemu/-/blob/master/include/qom/object.h?r=
ef_type=3Dheads#L1013
>
> The series needs to be rebased too, but probably it's better off to wait
> Jason to figure out the current situation of the series. Once it gets
> all sorted out, I'll rebase my series on top of it and ask for review.

Great, the pull request will be soon when 8.2 is released.

Thanks

>
> Regards,
> Akihiko Odaki
>


