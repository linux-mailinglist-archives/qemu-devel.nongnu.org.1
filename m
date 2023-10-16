Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD2D7CA7C6
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 14:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsMRY-0002X5-Gj; Mon, 16 Oct 2023 08:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@ziepe.ca>) id 1qsMRU-0002Wd-8j
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 08:11:28 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jgg@ziepe.ca>) id 1qsMRS-0000sL-KH
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 08:11:27 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7776f0d4187so2907785a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 05:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1697458285; x=1698063085; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zAhnYVS9AcMapW7LntALoHk1EkUQiC0DxFM0b/5Rd9U=;
 b=kbe13UdwVkfjiBi99+ReQeXoBOg0hrVxqKCpsyDkIiQFy449ZVJ+nphLUBdSGSnFrg
 CZby7Fg6xPcR+3zzg5Pdtd5pPU/4Z48kp1N2v4obgfX4lw6Hk6AQyprbq1eo2WQOtf53
 7xuF/je0SBene5wipj+uHw60sqdd5BgVQP4fRk39bA4fCQCkheMkT+DeZ7Fn3bvLSnjd
 woLLj3oe6FpxoM/++TJSLjwQ8CLVwkAJ8ru2bxb1GStDTlCA1jrnluObYzAvzqOzp7hu
 UaLNNGEIMevz/IEmTjnfEYjUm/Hgu7okgVpc4aBRlRCaPXNLUIc5fb7+O3XTLuDQT5og
 sUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697458285; x=1698063085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAhnYVS9AcMapW7LntALoHk1EkUQiC0DxFM0b/5Rd9U=;
 b=sNNxV/0ECvb55Psn0torVgZHXHMJHC0HmdGTozCMmlrD6UoXqlf5EUXz0TuK7GWW2q
 V6Aoz56bo53QLaxav6KmFo0WJxgALjm7XDzwfiCU5rFxwUO97Dg+g3uDDw779HBdYcip
 rnKqAD5JmDfUvFwPB+nFMYDWc+Weja47w4Q/1EHkCgX1G04piH1ZMpbAnVbQvGgySzFr
 iUu5XEW0haeA2DcuFvNXvAAI4Tnn/UAihyiC7M6GfeBp3L6GzGLT3WROS/YT943peBgH
 IwrZeQThYE3EwXqAyrz7xMQjSL/MB3EFi1tC6uJ17yDgSFtlMKfGCettQ5AkztO3ayK+
 Aodg==
X-Gm-Message-State: AOJu0YxEUOg+7u7wM9zGrCzZLC9xeADko6km2mvtWxK6m7GN+OrjJjPA
 lygBCg3sb9931h8tX273ksIEsg==
X-Google-Smtp-Source: AGHT+IGK2mfYjjZO9zCSPm/Y/SLBTahUJDKWRTidQRGGn9DlssoXWzD7+gB4ys64smmeEZzJWW6FIw==
X-Received: by 2002:a05:620a:21cc:b0:76f:1e31:93cd with SMTP id
 h12-20020a05620a21cc00b0076f1e3193cdmr33832505qka.43.1697458284945; 
 Mon, 16 Oct 2023 05:11:24 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.26.201]) by smtp.gmail.com with ESMTPSA id
 e5-20020a05620a12c500b007756c8ce8f5sm2919094qkl.59.2023.10.16.05.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 05:11:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qsMRP-001mtq-4i;
 Mon, 16 Oct 2023 09:11:23 -0300
Date: Mon, 16 Oct 2023 09:11:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
Message-ID: <20231016121123.GD282036@ziepe.ca>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-40-armbru@redhat.com>
 <9e117d0c-cf2b-dd01-7fef-55d1c41d254c@fujitsu.com>
 <b8f8ed5d-f20e-4309-f29c-960321ecad83@fujitsu.com>
 <87ttrhgu9e.fsf@pond.sub.org> <87zg17dejj.fsf@pond.sub.org>
 <9a9ac53b-e409-3b87-ea1b-e133903828a5@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9ac53b-e409-3b87-ea1b-e133903828a5@fujitsu.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d; envelope-from=jgg@ziepe.ca;
 helo=mail-qk1-x72d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Oct 07, 2023 at 03:40:50AM +0000, Zhijian Li (Fujitsu) wrote:
> +rdma-core
> 
> 
> Is global variable *errno* reliable when the documentation only states
> "returns 0 on success, or the value of errno on failure (which indicates the failure reason)."

I think the intention of this language was that an errno constant is
returned, the caller should not assume it is stored in errno.

errno is difficult, many things overwrite it, you can loose its value
during error handling.

Jason

