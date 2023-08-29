Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EDF78C87F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:23:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb0YC-0004sf-TY; Tue, 29 Aug 2023 11:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb0YB-0004sX-Gd
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb0Y4-0003hi-PS
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693322550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UlWemFggDX5d4f+pi2roibbsLFhidC4cpS7lZjZKDeo=;
 b=XuspBrxRwjgOK2t1hsbLF2zjTLL9Q5ZkIVoNOkPX46kjCOqmHhA97gsbbaKv8kxDzPu7qT
 3A6jt3YQeKsc2IoJn6mCHXGT41zf+kQ90HjntDpPvVpx13W+xjdnkWtwkLjVxKfpmcXMzB
 jx3aKvONP1wihQcOqCu2MNv3IiCmzWw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-1blo0rbzPEe35-lw8I-dWw-1; Tue, 29 Aug 2023 11:22:20 -0400
X-MC-Unique: 1blo0rbzPEe35-lw8I-dWw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65174aca002so1272136d6.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 08:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693322535; x=1693927335;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UlWemFggDX5d4f+pi2roibbsLFhidC4cpS7lZjZKDeo=;
 b=Ks31GBouOZHsc6r+DefPc4j6sU0uEiCHlY+aiDzYrghprGONk2gbGNviVdXlkik0PL
 yftW//QqMIttjdamlp/cl9FP2t6rQsAH4M6Tb3cV+eXcIP04Pmx1pQ3KbkMojZ3NnPPv
 4htg1Es16Bz4gKuM251MK58ZBPaQ/q6HJr0eeU+ljPszQJTNo4ZXZJJFy025+X68+eP8
 h0SL/Qzw03ROr85ka/0t76vZgLMe7l8Sjn/zGINBuLOouu6mwLFH63pV1XwkPnpbVoUm
 PE3Bp9ABr0oTz/J/dBgQvmLOfxWC84tkn2ItZ6fPtjdz6xdV1fTbrcWOTjUkCmKbydIp
 oX+g==
X-Gm-Message-State: AOJu0YxDif7xirePll3/BNfD4QNTAExacQTHocS9vATPSrRk7Eg2kmzn
 6lqVjZixT8JJGxI1AJ1GprGoJPNwPBWS7+uxRecPS+eqW41mBHkNP+7fQclJqf7sVLMVRNaK5Vz
 Ij9NUG6w/jB46K3h7M9af0o4=
X-Received: by 2002:ad4:5ba4:0:b0:63c:f852:aa3a with SMTP id
 4-20020ad45ba4000000b0063cf852aa3amr32355673qvq.4.1693322535240; 
 Tue, 29 Aug 2023 08:22:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqBo+1m+h6Efq9ulZevm4zmbPy6QT0IgYY41+T0LPiAklcA2IMRkIcc1d11OSpsEUlBwxcXQ==
X-Received: by 2002:ad4:5ba4:0:b0:63c:f852:aa3a with SMTP id
 4-20020ad45ba4000000b0063cf852aa3amr32355652qvq.4.1693322534985; 
 Tue, 29 Aug 2023 08:22:14 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g8-20020a0cdf08000000b0064f73bd872fsm3420821qvl.134.2023.08.29.08.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 08:22:14 -0700 (PDT)
Date: Tue, 29 Aug 2023 11:22:12 -0400
From: Peter Xu <peterx@redhat.com>
To: hongmianquan <hongmianquan@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: Re: [RESEND] memory: avoid updating ioeventfds for some address_space
Message-ID: <ZO4NJKDsIGYWQz5j@x1n>
References: <20230829022354.94149-1-hongmianquan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829022354.94149-1-hongmianquan@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Hongmianquan,

On Tue, Aug 29, 2023 at 10:23:54AM +0800, hongmianquan wrote:
> When updating ioeventfds, we need to iterate all address spaces,
> but some address spaces do not register eventfd_add|del call when
> memory_listener_register() and they do nothing when updating ioeventfds.
> So we can skip these AS in address_space_update_ioeventfds().
> 
> The overhead of memory_region_transaction_commit() can be significantly
> reduced. For example, a VM with 8 vhost net devices and each one has
> 64 vectors, can reduce the time spent on memory_region_transaction_commit by 20%.
> 
> Signed-off-by: hongmianquan <hongmianquan@bytedance.com>

Please feel free to take my R-b with the patch if the patch didn't change.

Thanks,

-- 
Peter Xu


