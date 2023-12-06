Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19451807627
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 18:12:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAvQJ-0005ve-Rk; Wed, 06 Dec 2023 12:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rAvQH-0005vH-Q8
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:10:57 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rAvQA-0001Cu-4J
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:10:57 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c19f5f822so246385e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 09:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1701882647; x=1702487447; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ygJQ11lVIy+dGwQu4ObcXGNlr5jdB1jPQ2GsWqZ4H6o=;
 b=ciym7cNReLdY3GLztV5+2auJfzdBMCEtDxjiBdBmJq3cogPZS/oOCCtUY1oCnc/H7B
 NwHPLz1D7BnkKlThu2zT1MBR+sx+wfqo9jjAztwqYGEYFCXj0b4xOVGhDxr+T9JkGmed
 tl4CLmfHoedDfSMGVd7gdye2AslrD3PmWn3/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701882647; x=1702487447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygJQ11lVIy+dGwQu4ObcXGNlr5jdB1jPQ2GsWqZ4H6o=;
 b=QwurtIRefJWj0OmJCJ+iQF6PXoGHuUwyIFOHzP+4ZmTkfocxbZ7knBjvQg0P02wb6s
 EOhNmmu6aW0VbeEtjpnS+Qf6lCusmohI3OMbiXZmZuzTzH7VtU0AlPxurr6JYnnupRDD
 qJ320o66x6AKs3DRK3p95WXabE5GjxnBVhQbdEoTIP8zajmeAevD4O0Z0XuKw7T+mG8j
 6tvYeXMAITJ3eyJEhLu0EMMrXRdbBYDGZYv4rFszAHaehBMpFKS9UzD0ijGq9OH9qj38
 TA4ygCOlsSlKnNchpY0tuIoAseAu6fCLi0L2wY38c+4kCznCyHv9+JlEKTldTNHWJf/0
 eBVA==
X-Gm-Message-State: AOJu0YzMoiKcW8B0kFphZaVXlubQZwseItpgLeIp95wLu+/mi4HzyTJF
 0lJGm0gA9wOlbtSAwlPrl3YtmQ==
X-Google-Smtp-Source: AGHT+IFtWcSHZ2oJLGyder4CwJPSnDHhLNNs7iy18nmFpsBl9eoDeOc0IorEktjQvawsGHALt4O/UQ==
X-Received: by 2002:a05:600c:3c99:b0:40b:2a08:c45e with SMTP id
 bg25-20020a05600c3c9900b0040b2a08c45emr1750816wmb.3.1701882647076; 
 Wed, 06 Dec 2023 09:10:47 -0800 (PST)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 he15-20020a05600c540f00b0040c25abd724sm296896wmb.9.2023.12.06.09.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 09:10:46 -0800 (PST)
Date: Wed, 6 Dec 2023 17:10:46 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Julien Grall <julien@xen.org>, Paul Durrant <xadimgnik@gmail.com>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Paul Durrant <paul@xen.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 2/6] xen: backends: don't overwrite XenStore nodes
 created by toolstack
Message-ID: <a5d439c6-f20d-41a6-8ec1-6132d505deb0@perard>
References: <20231202014108.2017803-1-volodymyr_babchuk@epam.com>
 <20231202014108.2017803-3-volodymyr_babchuk@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202014108.2017803-3-volodymyr_babchuk@epam.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=anthony.perard@cloud.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, Dec 02, 2023 at 01:41:21AM +0000, Volodymyr Babchuk wrote:
> Xen PV devices in QEMU can be created in two ways: either by QEMU
> itself, if they were passed via command line, or by Xen toolstack. In
> the latter case, QEMU scans XenStore entries and configures devices
> accordingly.
> 
> In the second case we don't want QEMU to write/delete front-end
> entries for two reasons: it might have no access to those entries if
> it is running in un-privileged domain and it is just incorrect to
> overwrite entries already provided by Xen toolstack, because toolstack
> manages those nodes. For example, it might read backend- or frontend-
> state to be sure that they are both disconnected and it is safe to
> destroy a domain.
> 
> This patch checks presence of xendev->backend to check if Xen PV
> device was configured by Xen toolstack to decide if it should touch
> frontend entries in XenStore. Also, when we need to remove XenStore
> entries during device teardown only if they weren't created by Xen
> toolstack. If they were created by toolstack, then it is toolstack's
> job to do proper clean-up.
> 
> Suggested-by: Paul Durrant <xadimgnik@gmail.com>
> Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
> Co-Authored-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> 

Hi Volodymyr,

There's something wrong with this patch. The block backend doesn't work
when creating a guest via libxl, an x86 hvm guest with qdisk.

Error from guest kernel:
"2 reading backend fields at /local/domain/0/backend/qdisk/23/768"

It seems that "sector-size" is missing for the disk.

Thanks,

-- 
Anthony PERARD

