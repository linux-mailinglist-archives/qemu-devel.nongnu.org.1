Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F5E824CAF
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 03:01:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLZW3-0008Vv-Ap; Thu, 04 Jan 2024 21:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLZW0-0008Vn-N9
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 21:00:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLZVz-0001xw-75
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 21:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704420050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JVXbtEbkdc0XDC5CIMi0gIxHSTjrJvlDxBPlVgoRV70=;
 b=cOJOLhGK2UIWWfdIf4hsEvWntd3NRw1WvRoqwUfA1PTccM3S4qthnjZiaOep8R/t3KsKt6
 Pzd95rIFUwtVg9m7EZzUkG/orSDRMJm/hzQoN7Ac/Dizrkp/heK6kH2PEfyzE8y/OvM12T
 +yXrDiuE5wnPS6KshpLgpH5s0iLnoC8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-FlnpyIeGNW6oG77j2b5OEQ-1; Thu, 04 Jan 2024 21:00:48 -0500
X-MC-Unique: FlnpyIeGNW6oG77j2b5OEQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d40e8aff1eso2014915ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 18:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704420047; x=1705024847;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVXbtEbkdc0XDC5CIMi0gIxHSTjrJvlDxBPlVgoRV70=;
 b=NvkCxbrDlp7SrqNYDTxzcodR6oVYaZ9r28Oq8gR9d3FJAZ6IOJ+Wq4ccAd/UmvA6i8
 qEuqhVp2YmUNgk5esIjaQueZVIKI6cYmOdQX65QAkQ/RQ6IHvHGJfPP/hCI9waUVABXb
 zErRnWj2lV8rGlcgy66PiH04pBEZrsHba0ElD1oZSYLTYP0OjbrOcP7J80BejkFDf7Jg
 cTI/xHm9St5Fz+68fraQYWPEvDAViJxCZkma7VGOPTsXZr4zXGZEG+uF+ntj90THZnv6
 LHGxNIws6xdwwj8AFygpIdmaERJTnNuWJcIE/sxU3vwI8dtQfzxVKOyEL4oWgsj7/LcN
 Qimg==
X-Gm-Message-State: AOJu0YxNfBxI7oJbokAbczBRuKSrdYcjI9LnHzEfdt74MYuVJgxOZx/e
 D0WEgTsPGwCHPWG8+uaV8rDWaLHz3OVZnblUqxWZxumfqWTtRT9Z9KbFFVFx5w6x9RzVBfLn1HB
 4RXZkIp6bc8PAO9hETtHkr+I6wCODT2Qt3lBO
X-Received: by 2002:a17:902:d50b:b0:1d4:f1c:634b with SMTP id
 b11-20020a170902d50b00b001d40f1c634bmr2720969plg.6.1704420047131; 
 Thu, 04 Jan 2024 18:00:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBm/sHu5yeP2+842Xol7i6gz41E1r2abMbgTb/tlSPLTBRcLB4qAXnjMkO/uEERo/ABr1qiw==
X-Received: by 2002:a17:902:d50b:b0:1d4:f1c:634b with SMTP id
 b11-20020a170902d50b00b001d40f1c634bmr2720951plg.6.1704420046814; 
 Thu, 04 Jan 2024 18:00:46 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t7-20020a170902a5c700b001d3dff2575fsm270420plq.52.2024.01.04.18.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 18:00:46 -0800 (PST)
Date: Fri, 5 Jan 2024 10:00:39 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/7] migration cleanups and testing improvements
Message-ID: <ZZdix41fVpLS0uPq@x1n>
References: <20240104142144.9680-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240104142144.9680-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 04, 2024 at 11:21:37AM -0300, Fabiano Rosas wrote:
> No change, just rebased on latest migration PR:
> 
> [PULL 00/26] Migration 20240104 patches
> https://lore.kernel.org/r/20240104043213.431566-1-peterx@redhat.com
> 
> v1:
> https://lore.kernel.org/r/20231124161432.3515-1-farosas@suse.de
> 
> These are some general cleanups and improvements to testing and
> debugging that I collected over the past month.

queued to staging, thanks.

-- 
Peter Xu


