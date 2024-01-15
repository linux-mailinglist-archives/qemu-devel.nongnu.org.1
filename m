Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F95982D3AD
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 05:37:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPEiO-0004xj-Rj; Sun, 14 Jan 2024 23:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPEiK-0004xQ-HU
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 23:36:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPEiI-0004Gq-KO
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 23:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705293401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZN3YruVbzGbAh3dKFFKK2m+m4SCfYmmecmF7/JOx2K8=;
 b=YtXadiwhsWGDFw9BbiqrvBr5wfdyJylIAF9UEBjKOMss55n9kfOHPtcr62Iw7aZEcUVqoD
 GZNzmXyKP1infci8JqUlcM2k9PfWgfwKKcFOIVmpNTF7OKMsLJqn3uubwC2jj763s3NOqb
 k8z5DxHbMvnwAljQBl37Yzi9myl4b4Q=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-Xywwfn3vPSmOWYfjxjIxYw-1; Sun, 14 Jan 2024 23:36:00 -0500
X-MC-Unique: Xywwfn3vPSmOWYfjxjIxYw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6da4d130a82so2191185b3a.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 20:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705293358; x=1705898158;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZN3YruVbzGbAh3dKFFKK2m+m4SCfYmmecmF7/JOx2K8=;
 b=cblXJJRdG11Pv18mmtvQcMaKYOg9E9hcF93ximm1ZN/6MnjTTS376YaQ4DH9xjrlWo
 USR4bIlO83RydVl+uI26K2SoCqWm5ViiS2oukP7qtCHguPmyIfYUXEfmNjCXW0XUg/1D
 aIqsrxmAKxix2fdIA0VvlPSUPu/470x2w2VpwheNNcCYx4zKEo4Ltz5TT5dh8mv0SKTg
 M7rX2w1bFvmfnb6aVxdseviIOxAXM8y2H4hj7nY/6nJRfOblJh0zVi+P4gd13dnvU6mS
 v2MGvhmZeMzGwcz2almLVWnvRZaGGPtDY82XdJL6hH0q7qewdmEB3s/8hTnhAy+3OaJ6
 x10A==
X-Gm-Message-State: AOJu0Yy0mXRsUskrKaxA17jEMHnY4CIheHO2FWV/XM23+vzOsNX6dXsc
 usJPDuLBdv+nqr0fGkDSPfUpB/70mg3C6r1CqH0571rZeQX5rJkllNuhEeXsrpN1p8C6penPygf
 fjlPtbLNhNrMKGHid+V2InGBghfvU5eNlRw==
X-Received: by 2002:a05:6a20:89a1:b0:199:501f:a08b with SMTP id
 h33-20020a056a2089a100b00199501fa08bmr8255993pzg.3.1705293358806; 
 Sun, 14 Jan 2024 20:35:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbDIpjtg2pjLZ2ad9Y8hxR2upP3OF3ESewy3vGXakf1fXE8IreLNP2UosMpT/aw/p22sFaQA==
X-Received: by 2002:a05:6a20:89a1:b0:199:501f:a08b with SMTP id
 h33-20020a056a2089a100b00199501fa08bmr8255988pzg.3.1705293358471; 
 Sun, 14 Jan 2024 20:35:58 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 m18-20020a170902c45200b001d0cd351baesm6780849plm.13.2024.01.14.20.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 20:35:58 -0800 (PST)
Date: Mon, 15 Jan 2024 12:35:48 +0800
From: Peter Xu <peterx@redhat.com>
To: Nick Briggs <nicholas.h.briggs@gmail.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 1/2] migration/rdma: define htonll/ntohll only if not
 predefined
Message-ID: <ZaS2JHceJNi-GX02@x1n>
References: <65a04a7d.497ab3.3e7bef1f@gateway.sonic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65a04a7d.497ab3.3e7bef1f@gateway.sonic.net>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 11, 2024 at 01:20:17PM -0500, Nick Briggs wrote:
> Solaris has #defines for htonll and ntohll which cause syntax errors
> when compiling code that attempts to (re)define these functions..
> 
> Signed-off-by: Nick Briggs <nicholas.h.briggs@gmail.com>

I left the other QGA patch for QGA maintainers, assuming this will enable
solaries build for qemu itself alone.

Queued this one for migration-staging.

Thanks,

-- 
Peter Xu


