Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D685B821834
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 09:12:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKZri-0007r3-Er; Tue, 02 Jan 2024 03:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKZrd-0007qb-Iy
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 03:11:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKZrc-00048c-2P
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 03:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704183061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHCkzghVSQDWF5YoKXlnYeDKNOmUMADj5ccuCrCoRvw=;
 b=F7NEh9TaVA+pjk8NRaWQLAqz9iGKqGch8qWBEgE+QiFFwMvqKW4SJbEF8Joqkrv/nGs82y
 JP9dVPBAp+pNxegGgGVaTcEsncpr2O9Ud3KUy3fZVExUq9T9OzXQ5jjE9aKOvj4dXriDyv
 zcCp9Hz3vnGlRioZd7HrSkt+LhyUkB4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-TY_TZBv-M3mWMmfvrLCYww-1; Tue, 02 Jan 2024 03:11:00 -0500
X-MC-Unique: TY_TZBv-M3mWMmfvrLCYww-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-427e291776aso101045711cf.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 00:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704183059; x=1704787859;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pHCkzghVSQDWF5YoKXlnYeDKNOmUMADj5ccuCrCoRvw=;
 b=eIh7SFknVIEPQvchp0i1B/NzHMIVcMZ1FFBHSPAgLGJwET7DJDn1LhQpzljohUJaXy
 mDNR+j3E4znLn8JVeIq7XP8PawwV7IH1+XffL6SHG4ICVvun9C/9odlj/6vIq63Vo7l7
 nR8ZoTbq1pMSGrkAOSPWUBaeH3/ynP2FDFjGtDN4uDIgfCEukGmvf8I+6+OoNYx/g3nc
 K+IetjoS6coQDLGwAwM0J5mzj9/xOhvU9Pvw9kSbMWZmXPXo671xgqFkb47uMDz0jkww
 WJx6S8G1evnk4MoZKUjBGu7D1DiRaNzgKEXuQvbLUyIiLzMi5FVBWeNAX8z98n8u1r/N
 jeAg==
X-Gm-Message-State: AOJu0YwO4oSSRT6JXJF4JmMCljYmDCKf7qcsr9cVVg3XbUKMgQZsRH45
 FJ4X1mVFZziTyJi/ccCIraLJ83inLqFwQ6EJEg+xrHgnZcrXtbGfcgtd4HseLuSo7EoJEhO5Jn8
 YMb1j8OeXemZZhqHEZEtrCqNzPHPBQRRfeAfHeDl3wJfM21qsJaZkIAkMJZKxMJkt1xiBPnr/kY
 RN
X-Received: by 2002:ac8:5d86:0:b0:425:93d0:8267 with SMTP id
 d6-20020ac85d86000000b0042593d08267mr23778217qtx.48.1704183059256; 
 Tue, 02 Jan 2024 00:10:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG59N1yVDFq2CG9N910rSK2vlxHHjEvnnRcuSNlom0DqWlyVg/7omubsE/mfn/92M42ba7/Eg==
X-Received: by 2002:ac8:5d86:0:b0:425:93d0:8267 with SMTP id
 d6-20020ac85d86000000b0042593d08267mr23778208qtx.48.1704183058865; 
 Tue, 02 Jan 2024 00:10:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 l8-20020ac84cc8000000b004257bf9a394sm12599119qtv.14.2024.01.02.00.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 00:10:58 -0800 (PST)
Message-ID: <a12b52a1-5e79-4e0b-84bb-98af94b1d571@redhat.com>
Date: Tue, 2 Jan 2024 09:10:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/iommufd: Remove the use of stat() to check file
 existence
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20231221080957.1081077-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231221080957.1081077-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 12/21/23 09:09, Cédric Le Goater wrote:
> Using stat() before opening a file or a directory can lead to a
> time-of-check to time-of-use (TOCTOU) filesystem race, which is
> reported by coverity as a Security best practices violations. The
> sequence could be replaced by open and fdopendir but it doesn't add
> much in this case. Simply use opendir to avoid the race.
> 
> Fixes: CID 1531551
> Signed-off-by: Cédric Le Goater <clg@redhat.com>


Applied to vfio-next.

Thanks,

C.




