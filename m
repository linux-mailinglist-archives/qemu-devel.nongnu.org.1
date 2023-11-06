Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B73247E2011
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:33:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxjo-0003l5-O5; Mon, 06 Nov 2023 06:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qzxjF-0003TF-Uv
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:25:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qzxis-0000Id-Nl
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699269888;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ujcDKPZRLPsIdyFGPGAB05RWJ+IiSUgGeHYWm2yz3L4=;
 b=Gehu/gwPsi420EIyzN5K0DHv+9c7zix70Mqtvpwt/kPS2Sz1hCNpQQfR8W+KGCKPm9GtRR
 VpAyGfZcP0+Fu+k0Evai1QnDwP6D19DKLVnfokdd055dVi99VNx4kstLxghPg/qBZY7Rn9
 ByN1gtKHKKXs1fRdbm4s7syihxcxHcA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-qNp5TEfzNVawpdE1-TMiNA-1; Mon, 06 Nov 2023 06:24:46 -0500
X-MC-Unique: qNp5TEfzNVawpdE1-TMiNA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-407da05ee50so27674005e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699269885; x=1699874685;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ujcDKPZRLPsIdyFGPGAB05RWJ+IiSUgGeHYWm2yz3L4=;
 b=pDwAyBfm6nUeLuF6i46Bk8s6bi5P3QYjYDVQaRhMHbtnBPCc06WTTFy7RrZ3SD5oCR
 6xcUoPJiKIUw1XPC5wqo9xOXKg9X1XtXQ99raEBKmZp2uq5DgJEjRxPcf6uRg5yKl3ZH
 tp4jGZOp/qZgmKIvQWoBOb27s3tavx3A/dBjPbNvJxLc91R3lOAmwFP+twGNxG0AYQxD
 QUFXAApoVX3bXyJjI3k3BfyG6X9gTa59ok9qSfQFcsIQVEfXOIHLGnAlmxhg9/ZTSLca
 aq4vXLJ71EOwjBS9tskdHJO270IfZTrHppkCbnQVmAiwHasckP/MGhw0HI7FIC6THM9l
 rtGQ==
X-Gm-Message-State: AOJu0YzMlQnCoKuz9dF4uI3MwNUiHeOPc9OCPGzXKbNKhPlV0KxoHJKe
 V2mt1nb9MauWQ3pOiIWVV/BfBMESDsQHeHjDPy4eZG8pFCqJsZdV5hSc9LJv8v91CxGA0VWAaX5
 zSKj3yZzyLusmrHM=
X-Received: by 2002:adf:f04d:0:b0:32d:9d66:5742 with SMTP id
 t13-20020adff04d000000b0032d9d665742mr20287375wro.10.1699269885749; 
 Mon, 06 Nov 2023 03:24:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmgyP+6x/u4FVlK21CVHMVfYebcRcohbxk4YgDC5MRspkR04sqL7KH1YmLGmqqLWtCetuYNQ==
X-Received: by 2002:adf:f04d:0:b0:32d:9d66:5742 with SMTP id
 t13-20020adff04d000000b0032d9d665742mr20287363wro.10.1699269885460; 
 Mon, 06 Nov 2023 03:24:45 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s6-20020a5d4ec6000000b0032f79e55eb8sm9184907wrv.16.2023.11.06.03.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:24:45 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 leobras@redhat.com
Subject: Re: [PATCH 70/71] tests/unit/test-vmstate: Constify VMState
In-Reply-To: <20231106065827.543129-71-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 5 Nov 2023 22:58:26 -0800")
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-71-richard.henderson@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 06 Nov 2023 12:24:44 +0100
Message-ID: <878r7b15vn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Richard Henderson <richard.henderson@linaro.org> wrote:
> While const data in tests is not particularly important,
> this makes a grep test clear across the tree.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>


