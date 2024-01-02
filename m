Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 262F9821769
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 06:34:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKXPC-0007Wm-8D; Tue, 02 Jan 2024 00:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rKXP8-0007Vx-Vz
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 00:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rKXP7-0004wH-DE
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 00:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704173607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DLuGyiCoaBVMrE7O9a34E+pfOlWA4Kw+204HbgIt3oo=;
 b=Ujz+s1OzSguTyvegf3uCfgdEZ/VpNPkWzonVoSjQlUoKQuyHs5sCqlKe0HeD5Kl0P6guTU
 B6r8KbmjJyCteyU0roDsIoeu0CiStAbwdDqaM8EbAG/nvLuleAdGy7k4ikfHe3o0RVpoYp
 xzL9jhi6JWdDE+w3Xx7myx6EGLhLQPs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-dK9wjsH-NeyJHPNxWjGj_Q-1; Tue, 02 Jan 2024 00:33:25 -0500
X-MC-Unique: dK9wjsH-NeyJHPNxWjGj_Q-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d99a379dacso1443658b3a.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 21:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704173605; x=1704778405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLuGyiCoaBVMrE7O9a34E+pfOlWA4Kw+204HbgIt3oo=;
 b=A+RC1/7ue2ENLLDkUxrvKML8mVmQped5aPclygJnyCl5ASf1++CzPA697RtjYLFbR5
 JkLt/9YHAKt0bKLJBCDsUmo1SZmc1LIviLlBzmXUMHnYPSdBflHAgdOAap+5eZrBmGV/
 tIFzRO5g9ApU+yd1kZsUY4vrxPnu33gjA+Gxt1Jbd/KHeyolYmeVQfOrqFIoR8OSsR2Z
 EtrSZZdS3Dv5raLKHgnmIZMAOmJBN5xtYEv756WDmWf3+PD0pmA5tcA3e3sqxBo0vt7r
 bvJLe6TmXf431Uw8F0TUU+aeLt2tQOjuSLu361gN6rqmVtOUvZiVHRTAJb5joNYdCk8F
 ED+A==
X-Gm-Message-State: AOJu0YxO3SzY5+JjCAz5huR/XSCulMkaIM+Y/KJhWXfDzoi3WhPXLmP4
 JBmunXUBeEdJs8EfY2Z73odChK7/dIKJzWNRUmV9GxcF76DkmJ3xHw3ZGKwvg5PJeuQGS+MszWT
 NdphikBNp1Q/D/1Qvo2ykWQ8=
X-Received: by 2002:a05:6a21:279e:b0:197:3a34:2889 with SMTP id
 rn30-20020a056a21279e00b001973a342889mr1497522pzb.3.1704173604805; 
 Mon, 01 Jan 2024 21:33:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4X0RRhUgvKbALWG1xE+s4n7v7Y6IGmhfp7HSxZwfZ304h084DxaaNFV465lAW3oV9E+65kA==
X-Received: by 2002:a05:6a21:279e:b0:197:3a34:2889 with SMTP id
 rn30-20020a056a21279e00b001973a342889mr1497506pzb.3.1704173604446; 
 Mon, 01 Jan 2024 21:33:24 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 p2-20020a170902eac200b001d0c09cc6ebsm20995850pld.92.2024.01.01.21.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 21:33:24 -0800 (PST)
Date: Tue, 2 Jan 2024 13:33:14 +0800
From: Peter Xu <peterx@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH for 9.0 08/12] vdpa: add vhost_vdpa_load_setup
Message-ID: <ZZOgGmpNT_zi2eat@x1n>
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-9-eperezma@redhat.com>
 <CACGkMEvH=uU4QxMHVHTo5tQiuML2+NTE3gZssfz84-+4kGHa1Q@mail.gmail.com>
 <CAJaqyWczW+uwYBsWas97JY6OgiSurnvNQnnTYPFWv5La55GOOg@mail.gmail.com>
 <CACGkMEukZNUnXRSwpVAROe7U7GzkubP9i37ev+qOSQvWxLEK_Q@mail.gmail.com>
 <CAJaqyWfGkboB4sN0PSukKx1kAV-QQ_YSWXWvksPScBD9OgHRsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJaqyWfGkboB4sN0PSukKx1kAV-QQ_YSWXWvksPScBD9OgHRsQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.246,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Jason, Eugenio,

Apologies for a late reply; just back from the long holiday.

On Thu, Dec 21, 2023 at 09:20:40AM +0100, Eugenio Perez Martin wrote:
> Si-Wei did the actual profiling as he is the one with the 128G guests,
> but most of the time was spent in the memory pinning. Si-Wei, please
> correct me if I'm wrong.

IIUC we're talking about no-vIOMMU use case.  The pinning should indeed
take a lot of time if it's similar to what VFIO does.

>
> I didn't check VFIO, but I think it just maps at realize phase with
> vfio_realize -> vfio_attach_device -> vfio_connect_container(). In
> previous testings, this delayed the VM initialization by a lot, as
> we're moving that 20s of blocking to every VM start.
>
> Investigating a way to do it only in the case of being the destination
> of a live migration, I think the right place is .load_setup migration
> handler. But I'm ok to move it for sure.

If it's destined to map the 128G, it does sound sensible to me to do it
when VM starts, rather than anytime afterwards.

Could anyone help to explain what's the problem if vDPA maps 128G at VM
init just like what VFIO does?

Thanks,

-- 
Peter Xu


