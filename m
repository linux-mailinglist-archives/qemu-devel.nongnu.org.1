Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18874730442
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 17:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Sp0-0000km-4m; Wed, 14 Jun 2023 11:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9Sow-0000kL-Ve
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 11:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9Sov-0003BY-06
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 11:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686758043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j/aJ3bK9LSeoSq+KaNpC+XBvaGMky8mMmLb8vt2nphs=;
 b=T7g/kVn59/pz0s/dqEmXv3RJ8F2Ivd+HWjlZqpV91E1/HvDdEvmLpVFKhKF608++X6JXww
 hIA+OOwznBX5DB7r4DmS/zG7WZ74SQy9SWcD2nMDjn/RDV00VMDHzBE9y6CNw3uNklM4Ym
 mbW7HVmsD/g6AMZEYFeVxFK+wJsmui8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-ofIBghPrNOaZ392n6vklfQ-1; Wed, 14 Jun 2023 11:54:02 -0400
X-MC-Unique: ofIBghPrNOaZ392n6vklfQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-62849c5e9f0so9301106d6.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 08:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686758042; x=1689350042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/aJ3bK9LSeoSq+KaNpC+XBvaGMky8mMmLb8vt2nphs=;
 b=RYYRrWU5HUC0vxNFtur6P22FuCs8WVmFm12ntuudcfjJylGPkrArLmBDF3ZRjMg9H4
 Wxo1fPIlu4GIqqzDlEdHFchSZqre5QY0uEOQ3QROpiaTxn+xVTiDPjFfKBkw/9eu51bj
 M1WSBtrQgZPpwJJ9llXZUxWfJsug4sJcgOpwCnln2Swsc5OVY3Yle1CeY298UOUjZOhN
 rG59SvZ7qiNwcfO912sgsezdiqhGmkL75nZCx5SLqV05iz07ECef9H+SJWn6IHFmM9y1
 maDhQ1s58TYEDXokbgcLyZX5b2AE2kwYQkgroSs3mpjG3cc0GdDeh79XG/l7EQt6oYcz
 /nzw==
X-Gm-Message-State: AC+VfDxDjpkD9UyZC9e+NdlFbEqZCKB+8q188MHvI8EiddM9DjFbqEcr
 9tC2gznqmhRMinqZEKuxGvNJESuoNpKZrt9DGZsuEheDmZYO7RFks2tbzLERPpke5Dv4XJGKLEY
 U81wjvpS0+LIyHaE=
X-Received: by 2002:a05:6214:e83:b0:62d:f62b:907 with SMTP id
 hf3-20020a0562140e8300b0062df62b0907mr5862868qvb.0.1686758042203; 
 Wed, 14 Jun 2023 08:54:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cfVdchUL7MJYrn9T7+fSEYrg3+ZmMUr5igQlc3ItaU/z9sEOh8XZDYlheIFJ/Qj0o73523g==
X-Received: by 2002:a05:6214:e83:b0:62d:f62b:907 with SMTP id
 hf3-20020a0562140e8300b0062df62b0907mr5862856qvb.0.1686758041992; 
 Wed, 14 Jun 2023 08:54:01 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u1-20020a0ced21000000b00619adb4b66asm4799219qvq.95.2023.06.14.08.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 08:54:01 -0700 (PDT)
Date: Wed, 14 Jun 2023 11:54:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 18/20] qemu_file: Make qemu_file_is_writable() static
Message-ID: <ZInimGWX1bXhRqv3@x1n>
References: <20230530183941.7223-1-quintela@redhat.com>
 <20230530183941.7223-19-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530183941.7223-19-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 30, 2023 at 08:39:39PM +0200, Juan Quintela wrote:
> It is not used outside of qemu_file, and it shouldn't.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


