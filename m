Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE667D3A56
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:04:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwTA-0001Q1-5V; Mon, 23 Oct 2023 11:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quwT4-0001Hu-T8
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quwT3-00059d-Ei
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698073424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lLJb4iD3WAtAcTyl+U3yqJBY23xDwPBsr2fnYopPkwg=;
 b=XxxnzZMYqraQ+pdAP+7MmTsEdLzCrlLNktF67+aXVlPRM3McTn0VWTnF6IBwfcjpLJXei5
 cxtWin7P2UoY+z7vWJ7XwqQFt7cs9oNKlASYHgjkq7bazn9pvASqJYM4DFo97tK2iRASoR
 OoJRvZE2jU+kpSAl0KdKX8/DULYfjdQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Y1TiIk7rPe-gumFU2TRhRA-1; Mon, 23 Oct 2023 11:03:33 -0400
X-MC-Unique: Y1TiIk7rPe-gumFU2TRhRA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-778a3e0b755so84382485a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 08:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698073412; x=1698678212;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLJb4iD3WAtAcTyl+U3yqJBY23xDwPBsr2fnYopPkwg=;
 b=VBWdNMTwNbuOCyoxt0W1eCw1bdm4gaT6n/HcsgV8RadBzesfOfTFcEDpm7ZjoDLQNU
 O5TXBANoWitd58xS6TbH6r3a29A3wuw3EVmPHI6I2shlMdbk12Bo5MEDPMDxKibss4q9
 +xmRRhh0/6o7JXW323ODrG95E6gqLbnZdtNyaiDPtI30UKD43Vf8ThCqnmHXy9YdHPvf
 g3CYukFUnpy3BUPkNfEDFExq/CUJPpOBJ8bhaO49IUcPMHP0x6jMkD2ZLRWJ0lx8wi+Q
 WPsfBXoQQgyY+zwzJZ89+fWjqEqiHjyEhiC32wmliLuY6iXT2axk3UvimLJkDO+M++4+
 ampg==
X-Gm-Message-State: AOJu0YwYi0fh9W7Np7hlIn4rZ3dekDUi5PXZben0NjpcMq2H896D3O5O
 EAEKmw2zYGYZAnRwBRfyJBhKqwkuzHd6+sT93SGHB3N48zHV6xI4VhDL7+s2fldLcWz4yQ6obQL
 tdLgIsmUcn3PLH3o=
X-Received: by 2002:a05:620a:a52:b0:770:f2bb:37c3 with SMTP id
 j18-20020a05620a0a5200b00770f2bb37c3mr9213795qka.6.1698073412536; 
 Mon, 23 Oct 2023 08:03:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnsntst3dhq80iP9Cnma9CcO7gWq2mjkvkE0nHplbU3y2dtdtEoVvDp1sYYRHYYuD7oi88LQ==
X-Received: by 2002:a05:620a:a52:b0:770:f2bb:37c3 with SMTP id
 j18-20020a05620a0a5200b00770f2bb37c3mr9213769qka.6.1698073412240; 
 Mon, 23 Oct 2023 08:03:32 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 i18-20020ad44bb2000000b0066d15724feesm2871682qvw.68.2023.10.23.08.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 08:03:31 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:03:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/2] migration: Simplify handling of zero pages
Message-ID: <ZTaLQSyd2DL9QyNS@x1n>
References: <20231019085259.13307-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019085259.13307-1-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Oct 19, 2023 at 10:52:57AM +0200, Juan Quintela wrote:
> Hi
> 
> It has been more than a decade since we optimized pages filled of
> anything except zeros.  Remove the reception support.
> 
> Review please.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


