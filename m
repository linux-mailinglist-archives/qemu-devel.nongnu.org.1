Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 419277FF8C8
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 18:48:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8l83-0004n7-4L; Thu, 30 Nov 2023 12:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8l7o-0004mO-0S
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 12:46:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8l7m-00031L-N7
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 12:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701366413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=36I5dLdDPjWyeCL12KYtafeS98q0dzJu36IdMWUqn0o=;
 b=bvgJrwcKkx2UKgM/VFryWSW1jDQVDXjHph0SSdwcD6E95e0RQdTyYFJUHMoFjPGffFfuEp
 Rbexy3BaYOut5gVG4fGMeZiZvCC77nDilMgbSGBEDnpJnV7bQG/3JViTOpsk4eU9Qykm8w
 nXvfVTK1vfcbm0GckV/9Vr9KdtqYOrk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-mPri4f51P1Gx4W6XYs8ZSQ-1; Thu, 30 Nov 2023 12:46:52 -0500
X-MC-Unique: mPri4f51P1Gx4W6XYs8ZSQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-67a06b43afcso3631186d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 09:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701366411; x=1701971211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=36I5dLdDPjWyeCL12KYtafeS98q0dzJu36IdMWUqn0o=;
 b=epWdjyQm5AqJ7Ma92KD0/hOK9URLCsNyFhN6KLOG4FF1dWXwlrdVmCuFbD6dZDAoY3
 ugz0W4JjnO+gKEEpH0cDNB8x5DCN6Vg65QRRm8LYmU+T7Vq5q4JIRHUrwscMkw36TFw3
 67irY370A+jTQLLyjEXR1xkcdK9SKdXJf9+WK1auk78RoYC4g/GuJr1NULfmK5Qh/rLf
 M/9Fv3l0WI8bx1K37telBWlGh6bFg1vIZHXRu2j0r2FuPJC95GN6OdrQQ+m+NqMsy1L9
 E8H704WJOXb7lf+o8iXgsBPna4Lxy04aJFVk7lbOoX50pl1bENZlSe3TkDATUqKFapDF
 15hQ==
X-Gm-Message-State: AOJu0Yy1uIhaJmlK+VAsqSeq+eFqSi4HQ+PYSIDwFqynjUp46T3QPoG4
 c9HrpyxfxygrvHdaYVYtqmiBR8T+6phKq8B7lWb9pGRVxZXEXjdThN2CAKqTRzpHdh7OUxZj9Ki
 3jKH9g/X5uuZOaLk=
X-Received: by 2002:ad4:4085:0:b0:67a:1673:fec4 with SMTP id
 l5-20020ad44085000000b0067a1673fec4mr23023345qvp.2.1701366411714; 
 Thu, 30 Nov 2023 09:46:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrwAfPkyoM5agFa8bqH8//SMn/Txut1an3SMNcAFFZOVZCrPk5A8jIwhA4JHR7Kt/V7x+pIQ==
X-Received: by 2002:ad4:4085:0:b0:67a:1673:fec4 with SMTP id
 l5-20020ad44085000000b0067a1673fec4mr23023320qvp.2.1701366411412; 
 Thu, 30 Nov 2023 09:46:51 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ka7-20020a05622a440700b00423f1cc1227sm681028qtb.43.2023.11.30.09.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 09:46:50 -0800 (PST)
Date: Thu, 30 Nov 2023 12:46:48 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v3 03/70] RAMBlock/guest_memfd: Enable
 KVM_GUEST_MEMFD_ALLOW_HUGEPAGE
Message-ID: <ZWjKiDy3UMq3cRkD@x1n>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-4-xiaoyao.li@intel.com>
 <bc84fa4f-4866-4321-8f30-1388eed7e64f@redhat.com>
 <05f0e440-36a2-4d3a-8caa-842b34e50dce@intel.com>
 <0fbfc413-7c74-4b2a-bade-6f3f04ca82c2@redhat.com>
 <4708c33a-bb8d-484e-ac7b-b7e8d3ed445a@intel.com>
 <45d28654-9565-46df-81b9-6563a4aef78c@redhat.com>
 <ZWixXm-sboNZ-mzG@google.com>
 <d6bfd8be-7e8c-4a95-9e27-31775f8e352e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6bfd8be-7e8c-4a95-9e27-31775f8e352e@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 30, 2023 at 05:54:26PM +0100, David Hildenbrand wrote:
> But likely we want THP support here. Because for hugetlb, one would actually
> have to instruct the kernel which size to use, like we do for memfd with
> hugetlb.

I doubt it, as VM can still leverage larger sizes if possible?

IIUC one of the major challenges of gmem hugepage is how to support
security features while reusing existing mm infrastructures as much as
possible.

Thanks,

-- 
Peter Xu


