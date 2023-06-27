Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2973F374
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 06:35:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE0QL-0004Jd-Lt; Tue, 27 Jun 2023 00:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE0QD-0004Iv-0s
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 00:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE0QA-0007sP-U0
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 00:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687840516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hbixdtDYLseCrbR7xGI0f5d+yBIotHo7BkYDQ6lEWQQ=;
 b=CxyXG78DG8TsPxZB0Ny2uq3YA2xMddEoHNlrcH24ZjcSAQI9fN4ZuM45sN5pVqvQvQCY4D
 PCyfj+02qlHHrsKcsyLYYn47AL55pkJXn9NjrCxxyoIerVw3Ms4LaOT4uecs+whRMyQZyg
 yj8JdSVLnh68oPFSFmI78Ajaj0Jf8zQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-t1l9VZEyN0umjTANUP749A-1; Tue, 27 Jun 2023 00:35:14 -0400
X-MC-Unique: t1l9VZEyN0umjTANUP749A-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1b03f7fb970so1445363fac.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 21:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687840514; x=1690432514;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbixdtDYLseCrbR7xGI0f5d+yBIotHo7BkYDQ6lEWQQ=;
 b=XrXvXGoyQFvnarhXh+0g3W64n39S5+lD+nBgTG0bKdzI1revKYM0mk762Vmvo1QmNn
 vg8TlMbPyRkMKNOSPF2gb0WKV3VcwYba2eWf0qeRuGNQ6pu9XnQv1P7At00cRuNK506l
 O0MLTi8uinvtrUHXE7MKs+n4oA9nhtVlGP+C4G6FA8+wCzl7OxMyhYPVg1pB2GxuQNUA
 BaxI+9JnGBF7evT07wBjLUawNw++yiWpg3mZQCqovmjpE5tXib3OSd0F8RWLzt+ixTOv
 N/JwmrU/pBYHofpy6IW35MLnCHOWxm0xPBf548G9NnE0z11WAyQDiulaunVfbbFYNgIR
 NynQ==
X-Gm-Message-State: AC+VfDztjpUY6n3HDxUxeOrKPoVJUepEUVr+2cT+QNvJxv3CftMA1Ebp
 OmL9uEK99A+2vLLInroONIMG+S+mkOp8B7NNGnwXQn8CSMIVX145b0t06masEV2WraMxvBoGEcU
 tN8EXbLZIJi8SEl4=
X-Received: by 2002:a05:6870:a441:b0:1b0:4469:1cc3 with SMTP id
 n1-20020a056870a44100b001b044691cc3mr2814174oal.58.1687840513930; 
 Mon, 26 Jun 2023 21:35:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4yHxieW5+mculIiYyHcEFO61pP9JBRgv9YvDDPNYXYsWQWywFGMLgSdzk6IJYm+vy5ezB1Vg==
X-Received: by 2002:a05:6870:a441:b0:1b0:4469:1cc3 with SMTP id
 n1-20020a056870a44100b001b044691cc3mr2814162oal.58.1687840513624; 
 Mon, 26 Jun 2023 21:35:13 -0700 (PDT)
Received: from smtpclient.apple ([116.73.132.30])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a63f94e000000b005143448896csm4833186pgk.58.2023.06.26.21.35.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Jun 2023 21:35:13 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PULL 53/53] vhost-vdpa: do not cleanup the vdpa/vhost-net
 structures if peer nic is present
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <bd539426-a69c-9cbc-5f24-4fbe5a236fd6@tls.msk.ru>
Date: Tue, 27 Jun 2023 10:05:07 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, imammedo@redhat.com,
 jusual@redhat.com, Jason Wang <jasowang@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F194DEA-910C-4734-9184-C74A99BB9CF0@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
 <3d90d47995b83bd1edf6e756c00e74fd5ec16aee.1687782442.git.mst@redhat.com>
 <bd539426-a69c-9cbc-5f24-4fbe5a236fd6@tls.msk.ru>
To: Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 26-Jun-2023, at 9:23 PM, Michael Tokarev <mjt@tls.msk.ru> wrote:
>=20
> 26.06.2023 15:30, Michael S. Tsirkin wrote:
>> From: Ani Sinha <anisinha@redhat.com>
>> When a peer nic is still attached to the vdpa backend, it is too =
early to free
>> up the vhost-net and vdpa structures. If these structures are freed =
here, then
>> QEMU crashes when the guest is being shut down. The following call =
chain
>> would result in an assertion failure since the pointer returned from
>> vhost_vdpa_get_vhost_net() would be NULL:
>> do_vm_stop() -> vm_state_notify() -> virtio_set_status() ->
>> virtio_net_vhost_status() -> get_vhost_net().
>> Therefore, we defer freeing up the structures until at guest shutdown
>> time when qemu_cleanup() calls net_cleanup() which then calls
>> qemu_del_net_client() which would eventually call =
vhost_vdpa_cleanup()
>> again to free up the structures. This time, the loop in net_cleanup()
>> ensures that vhost_vdpa_cleanup() will be called one last time when
>> all the peer nics are detached and freed.
>> All unit tests pass with this change.
>> CC: imammedo@redhat.com
>> CC: jusual@redhat.com
>> CC: mst@redhat.com
>> Fixes: CVE-2023-3301
>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> Message-Id: <20230619065209.442185-1-anisinha@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  net/vhost-vdpa.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 9e92b3558c..e19ab063fa 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -207,6 +207,14 @@ static void vhost_vdpa_cleanup(NetClientState =
*nc)
>>  {
>>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
>>  +    /*
>> +     * If a peer NIC is attached, do not cleanup anything.
>> +     * Cleanup will happen as a part of qemu_cleanup() -> =
net_cleanup()
>> +     * when the guest is shutting down.
>> +     */
>> +    if (nc->peer && nc->peer->info->type =3D=3D =
NET_CLIENT_DRIVER_NIC) {
>> +        return;
>> +    }
>>      munmap(s->cvq_cmd_out_buffer, =
vhost_vdpa_net_cvq_cmd_page_len());
>>      munmap(s->status, vhost_vdpa_net_cvq_cmd_page_len());
>>      if (s->vhost_net) {
>=20
>=20
> Given the CVE# attached, is it a -stable material?
> The same change can be applied to 8.0 and even to 7.2, with slight =
difference
> in context (using qemu_vfree() instead of munmap() for =
cvq_cmd_out_buffer etc).
> The original bugreport is about qemu 7.1.

Yes I think it can be applied to 7.2 and 8.0. I back ported the patch on =
stable-8.0 and tested it and it seems to fix the issue. I have not =
tested on 7.2.



