Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF09C7AB4C6
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:29:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qji57-0004XD-8C; Fri, 22 Sep 2023 11:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qji55-0004WC-4N
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qji53-0008Kb-Ja
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695396513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VpGFGUXliy4Wv9oeb+pfOnex40qDhgxdKbOqPY60HFA=;
 b=WaYelrXmD6hp2+fSRWqGWUrIsJhwOi+NT4O9qvReNis/FgkM6R+unH1WLWHnZwvSKOoDTp
 PtFRLcuVazjk6UA91XozdTVPCCuuNZWulKiICbKJZoD2z4bJrKKySoTlRdIZc0c7nla4wW
 hunWxSJjcORd1GLcqmBfdA62yz8GKKw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-vDapqgXMNBifcPSRMBbjaw-1; Fri, 22 Sep 2023 11:28:28 -0400
X-MC-Unique: vDapqgXMNBifcPSRMBbjaw-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6c461fc0abcso524029a34.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695396508; x=1696001308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VpGFGUXliy4Wv9oeb+pfOnex40qDhgxdKbOqPY60HFA=;
 b=bWfEMQ+xuaWix8mf9ARbqBwZ7wgLKthHFzHOA2BCjAi/9acYxek4b5y+ApLx3iN5na
 lXZSSx1bdGCZ0Skd6C73sEUFvPhYjoqfYMQfslACT4fzOHf3fLYcl0J6lBwyNCGjIcRz
 ISFHZXTG8NdzgWJXN2eKwKjMXiCqtSGKp6QMrZCp7tKY9oqRST9XZLuYobYDW/bsHfKz
 N3vxvXmv+eOcdFEaE8CPneLuIrGptoFgrGGuOmldzaNPfuok2n2dTtWjQoQRoLBGxeER
 cCNJbCK1bkhQtF/O4MplDm3RjgSjLXYtwYlCSxZik5zzY+S935ilnmj3YHuYCddziORU
 F4Vw==
X-Gm-Message-State: AOJu0YyyfZl0Fuqnh4/5ZS2Bkypohx22QxmChR1ZdpU76SA3gWtqNO8q
 gBzrsLZghC6sgjl5pvUsNuJbgP88tEnWagItbiKs4WdXU7UYe/D4b74u7vtsahZ5cPSgSv3llMQ
 nJaolVueS5+fyQwY=
X-Received: by 2002:a05:6830:46a1:b0:6bd:6d51:e9e5 with SMTP id
 ay33-20020a05683046a100b006bd6d51e9e5mr94420otb.0.1695396507971; 
 Fri, 22 Sep 2023 08:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsfnkdX7SiPqXSxcoScPWYeqokKwzAtQPejZ20JRDJYD0NtddejDM1HMR6ME2EDc8c20kIjQ==
X-Received: by 2002:a05:6830:46a1:b0:6bd:6d51:e9e5 with SMTP id
 ay33-20020a05683046a100b006bd6d51e9e5mr94402otb.0.1695396507726; 
 Fri, 22 Sep 2023 08:28:27 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g6-20020ae9e106000000b0076d74da4481sm1489464qkm.23.2023.09.22.08.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:28:27 -0700 (PDT)
Date: Fri, 22 Sep 2023 11:28:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 2/5] softmmu: Support concurrent bounce buffers
Message-ID: <ZQ2ymKH7t9nBjNH4@x1n>
References: <20230920080622.3600226-1-mnissler@rivosinc.com>
 <20230920080622.3600226-3-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920080622.3600226-3-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 20, 2023 at 01:06:19AM -0700, Mattias Nissler wrote:
> When DMA memory can't be directly accessed, as is the case when
> running the device model in a separate process without shareable DMA
> file descriptors, bounce buffering is used.
> 
> It is not uncommon for device models to request mapping of several DMA
> regions at the same time. Examples include:
>  * net devices, e.g. when transmitting a packet that is split across
>    several TX descriptors (observed with igb)
>  * USB host controllers, when handling a packet with multiple data TRBs
>    (observed with xhci)
> 
> Previously, qemu only provided a single bounce buffer per AddressSpace
> and would fail DMA map requests while the buffer was already in use. In
> turn, this would cause DMA failures that ultimately manifest as hardware
> errors from the guest perspective.
> 
> This change allocates DMA bounce buffers dynamically instead of
> supporting only a single buffer. Thus, multiple DMA mappings work
> correctly also when RAM can't be mmap()-ed.
> 
> The total bounce buffer allocation size is limited individually for each
> AddressSpace. The default limit is 4096 bytes, matching the previous
> maximum buffer size. A new x-max-bounce-buffer-size parameter is
> provided to configure the limit for PCI devices.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


