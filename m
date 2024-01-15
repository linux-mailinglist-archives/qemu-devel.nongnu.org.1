Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B239482D8ED
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 13:35:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPLji-0002mH-FF; Mon, 15 Jan 2024 07:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPLjg-0002kP-Vi
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 07:06:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPLjf-0005MU-0s
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 07:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705320393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LKi6h+Iip+kJimtoHvqxskHIukadBIsvnErrV6nvXH4=;
 b=E1Kw0PUMCFLZvzzzMIC9clmA2MrB6dQpARrCKRspL5VSGBsl3IWP2XolYkrgnUlmIG9xgn
 NYfy/mXJkd6Hr9z9jwlmMveLk1eG2nTH1fzedjXPgZVrmRUIKTsh7ybFUmMLbdcQ9nyF1e
 vVFRPPNflwYxNcvubp0Z60rVDiKirPM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-KI4BJISWMG6G8KRE_Sgm9g-1; Mon, 15 Jan 2024 07:06:32 -0500
X-MC-Unique: KI4BJISWMG6G8KRE_Sgm9g-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28cb02a6027so1488852a91.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 04:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705320391; x=1705925191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKi6h+Iip+kJimtoHvqxskHIukadBIsvnErrV6nvXH4=;
 b=D8YhyfxCKQ4sgQhSL/DX7n5gRK6+oS/G874+2roIKDc8fYBjOHp0yAf8ueqC0DfmJg
 pBX9/NbsRHo904hgXBFXncdNygUyzFRdyHlM65TL63gtJAPb0x3mkT2oWbUlLYUiEo4H
 H3ipQu2P+0y+jVGo2nEgjQP9vB+bwiypB642ik881lD4x9elKFKZPjgUTNp0761xMTLR
 MwKObwa8Jfq1NLTHFBZE3GcjKiNaCVK3IJ6CnEAaCjhxi8z8kfgtKv0hTluz98xwTbdD
 y4g7Txpn1KJ4+xuiUcI+NnvkNyNGiHGH8OT3t6Qqya51KxM29h45fKAlqg0zris3tyzz
 3Jkw==
X-Gm-Message-State: AOJu0YyF3N3CuTaFn5iO6zGolm8+zFm+pjTiERHEZEMlARPBrQguoBJY
 JzjmgcohxZ+cBqIysvJYQZcfgaLNXeHOSSDCmma6v0mfeqqsxuzLkxfMqQViiqszcPd9tmtbYLS
 Bo+phOAuFIfVFU/jlPxJ24as=
X-Received: by 2002:a05:6a20:2e1f:b0:196:16b0:c554 with SMTP id
 be31-20020a056a202e1f00b0019616b0c554mr8231513pzb.5.1705320391217; 
 Mon, 15 Jan 2024 04:06:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbNcIqOr5/LmWCyZe5+dq4q7fYdHxt6I3KaZHij4Mk/+sTEFBCW/wmxcLpIqotsxd6WWQn5g==
X-Received: by 2002:a05:6a20:2e1f:b0:196:16b0:c554 with SMTP id
 be31-20020a056a202e1f00b0019616b0c554mr8231499pzb.5.1705320390934; 
 Mon, 15 Jan 2024 04:06:30 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 h18-20020a17090adb9200b0028c89298d36sm6989246pjv.27.2024.01.15.04.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 04:06:30 -0800 (PST)
Date: Mon, 15 Jan 2024 20:06:18 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 12/30] migration/multifd: Allow QIOTask error
 reporting without an object
Message-ID: <ZaUful1Vtn0d7--8@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-13-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-13-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Nov 27, 2023 at 05:25:54PM -0300, Fabiano Rosas wrote:
> The only way for the channel backend to report an error to the multifd
> core during creation is by setting the QIOTask error. We must allow
> the channel backend to set the error even if the QIOChannel has failed
> to be created, which means the QIOTask source object would be NULL.
> 
> At multifd_new_send_channel_async() move the QOM casting of the
> channel until after we have checked for the QIOTask error.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> context: When doing multifd + file, it's possible that we fail to open
> the file. I'll use the empty QIOTask to report the error back to
> multifd.

The "context" can be slightly reworded and put into the commit message too.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


