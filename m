Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D437F1516
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 15:02:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r54qF-0006kR-RF; Mon, 20 Nov 2023 09:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r54q2-0006hd-6t
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:01:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r54pv-0007Dn-Fp
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700488871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMEKTOtGqnJL6oLeCSsrQVTCnPHP5Rl23/Rt6nwAXes=;
 b=beZQecDpY7Bl0mr0Xua6yvPJ7SSmF4jC8otliZQJp4EzVvrj0kUb3o+9pjjWdmUIDBwBxA
 AEnBq+Pm9XBsy7TBmKmCUF271LHO6fhBZkmNuXT6x2Diqvi32XebCVhmMmFOB1Jw9AWiiu
 EVRPXIjTJfpHmnCxS3OrgP/mRJO/4ZA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-CYQKszzPNeSD7QN1UFSdCg-1; Mon, 20 Nov 2023 09:01:08 -0500
X-MC-Unique: CYQKszzPNeSD7QN1UFSdCg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6755f01ca7dso11778756d6.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 06:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700488866; x=1701093666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMEKTOtGqnJL6oLeCSsrQVTCnPHP5Rl23/Rt6nwAXes=;
 b=RamnvTN3PV7ZSdSRH5JZgUjE16/chVTigBNgVaZuRE8GU9MeiBDvSxC6GllEKW4FGV
 hD4gplZnV6LjFaBp2SbgxVx1rYIUPT4CDuMJcji6FxRHGdw0odBFbcn36jtQtTAckSbY
 zod+1rqJ0psL5ikOmVq4vpFe9CMgCxHFW4TAely7c9UN4FtBqr8VBs9hcjE5B5wJtKJC
 qD9kx1SRzho8JgR3i4lkWZa0Oa21RnGHo4DAKZxdNnel07mvmd3pKiCVm7nhQ0gC4KCj
 PuoSm2OiFlVAjZmilI8k7U0rXsqsDqkDLD31etRbOMx9r21nUrBjmF0YxE+f+5YetOul
 xy0Q==
X-Gm-Message-State: AOJu0YxolVpRKIy+Iw58mzDGM/hmfJs5Kn2/9dlLqpX1CkWHVGCG6IB4
 PeyFEG4gYnMywKwiNIGzlyD6Wlajpz2z7oXRtyH2IdqwqHpm5dUpezFwxbtKgbfUqELG37d5AOg
 HIPQUycW5mvzM0Qc=
X-Received: by 2002:ad4:5009:0:b0:679:df1b:c3c1 with SMTP id
 s9-20020ad45009000000b00679df1bc3c1mr1838682qvo.3.1700488866577; 
 Mon, 20 Nov 2023 06:01:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSl2lHTvkzF7Gcpt7dpLqMO92eXsSjidLIpYjtiUnRtQmSn4lmIZtwU8y9mllH5ypy2NhutQ==
X-Received: by 2002:ad4:5009:0:b0:679:df1b:c3c1 with SMTP id
 s9-20020ad45009000000b00679df1bc3c1mr1838633qvo.3.1700488865890; 
 Mon, 20 Nov 2023 06:01:05 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 o5-20020ac86985000000b0040399fb5ef3sm2675939qtq.0.2023.11.20.06.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 06:01:05 -0800 (PST)
Date: Mon, 20 Nov 2023 09:01:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Zongmin Zhou <zhouzongmin@kylinos.cn>
Cc: berrange@redhat.com, farosas@suse.de, leobras@redhat.com,
 qemu-devel@nongnu.org, quintela@redhat.com
Subject: Re: [PATCH v3] migration: free 'saddr' since be no longer used
Message-ID: <ZVtmn0WXTKPxCbKU@x1n>
References: <ZVdw_XMJ4mKMFejd@x1n>
 <20231120031428.908295-1-zhouzongmin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231120031428.908295-1-zhouzongmin@kylinos.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Nov 20, 2023 at 11:14:28AM +0800, Zongmin Zhou wrote:
> Since socket_parse() will allocate memory for 'saddr',and its value
> will pass to 'addr' that allocated by migrate_uri_parse(),
> then 'saddr' will no longer used,need to free.
> But due to 'saddr->u' is shallow copying the contents of the union,
> the members of this union containing allocated strings,and will be used after that.
> So just free 'saddr' itself without doing a deep free on the contents of the SocketAddress.
> 
> Fixes: 72a8192e225c ("migration: convert migration 'uri' into 'MigrateAddress'")
> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


