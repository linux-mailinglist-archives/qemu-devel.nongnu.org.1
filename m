Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE6792411
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:47:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdYGx-0007JZ-GS; Tue, 05 Sep 2023 11:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYGn-0007BY-4X
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYGj-00076P-BN
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693928828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mu6yG40PFElfELrlUJu7B4Kuwli03YxaJZluXdbUq0g=;
 b=cZo5zsmkdMJ/FmDTjZFk+nGRYFN9RW4jSD1R9HwvmdhgK7b6KgD9cEOM46fSFu4GlQkFnt
 Y2knVNURyj251iGULlVsg9hEqXrVLvTAHn4d7dkbmlkX5OLqU5O13arsUpg325rJ4fTdhG
 OSZb7QaaWm+w3G+Td9Gwlp1OQqodJIQ=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-VvJXqOO_O8K9j_Bnsoi6hA-1; Tue, 05 Sep 2023 11:47:07 -0400
X-MC-Unique: VvJXqOO_O8K9j_Bnsoi6hA-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-44d41be3074so164974137.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 08:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693928827; x=1694533627;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mu6yG40PFElfELrlUJu7B4Kuwli03YxaJZluXdbUq0g=;
 b=bvEV7+Et3yb79lFmyHFuW42SEhiU/rQm4Rtdic1ZPxKuPnBiPBsdkpKgaylz46K2tL
 u3ZeMMQAeMoWbRpGyfk7wtvhGqIJf66Y5EAc913WZoj/vuFmSr/XnpQ8DkIWq1ZOM4NK
 hcIM5S+ujgTtDlBUBtQO8c52QwMcVpSzxRbWqIWtIJWkME0J1OsGJyiYV0kR7ghG4CLt
 NVhI0znJI+p4FuyHuzD+9fWMdsPiXYAHM/sgs0YL2epTve/dNUDK1MjSMzaUZ+g2PSol
 lzTgbx5m2mQ0PYq4pj0+AikVjRdeEsl6KPbKN1paiSEup71Cq85E0O+kgSc3vgO/tZG9
 CX5w==
X-Gm-Message-State: AOJu0YzWe9J1UqTsD+j8Z0iszLAhKmDzb9asomJFuUb0AbaZVl6hPG1e
 GrQNSScVSLvGcEDgqbrkOIXCKZYkI+HZ6aiab0vMl8dFkPLFJN3ckoeIxfcMx+K5KHvtyDdXv+Q
 el6ozQ91oF76QQn8=
X-Received: by 2002:a67:fc48:0:b0:44d:4dd6:7969 with SMTP id
 p8-20020a67fc48000000b0044d4dd67969mr9394493vsq.0.1693928826752; 
 Tue, 05 Sep 2023 08:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwosazBoPmYEoTODQErbaOgx2eyxbFR95+Cuik7N8TP5X+NKRlY1fL67c58+Xo5BCyCZkoqQ==
X-Received: by 2002:a67:fc48:0:b0:44d:4dd6:7969 with SMTP id
 p8-20020a67fc48000000b0044d4dd67969mr9394481vsq.0.1693928826526; 
 Tue, 05 Sep 2023 08:47:06 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ml9-20020a056214584900b0063d316af55csm3509259qvb.3.2023.09.05.08.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 08:47:06 -0700 (PDT)
Date: Tue, 5 Sep 2023 11:46:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 21/22] softmmu/memory: Clean up local variable shadowing
Message-ID: <ZPdNc5cPI6N2+thi@x1n>
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-22-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230904161235.84651-22-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 04, 2023 at 06:12:33PM +0200, Philippe Mathieu-Daudé wrote:
> Fix:
> 
>   softmmu/memory.c: In function ‘mtree_print_mr’:
>   softmmu/memory.c:3236:27: warning: declaration of ‘ml’ shadows a previous local [-Wshadow=compatible-local]
>    3236 |         MemoryRegionList *ml;
>         |                           ^~
>   softmmu/memory.c:3213:32: note: shadowed declaration is here
>    3213 |     MemoryRegionList *new_ml, *ml, *next_ml;
>         |                                ^~
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


