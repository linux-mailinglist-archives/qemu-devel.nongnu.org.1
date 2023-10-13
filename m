Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC837C8114
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:57:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDxi-0000yf-V7; Fri, 13 Oct 2023 04:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrDxg-0000ge-8x
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrDxe-0002ZZ-Gl
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697187357;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=enNXeaUpCO7zooqkTTySvf/iJbvcwsZXeaFsckRPino=;
 b=cbNS2On5KqjzWkDjT8iONNLWWYwxFvvOhLAWNCknu3Dfih/sG5nhm01v6679nKzcNwWaki
 a9VgATv0WByLoqNtvEhcOmgEaOanFWTLTwbZVUHvGjTb90x/T4xguDyZMxiUIhWm+6gcWp
 pAixqtIJ0SDMfWJzMQ6aSr55knz26Is=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-oNJ4o4bvNweqxO69zwNbMw-1; Fri, 13 Oct 2023 04:55:50 -0400
X-MC-Unique: oNJ4o4bvNweqxO69zwNbMw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5042bc93273so1765688e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187349; x=1697792149;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=enNXeaUpCO7zooqkTTySvf/iJbvcwsZXeaFsckRPino=;
 b=KybsrTfh3CCqwyTSIxrCQtEJhYZGwD154R+CJwUDHKLB1YItlcuVQtqUA+8xZclU8h
 HSgERrNR7o7UrMrms8UZghUwupcem0M6QjbG9wBnCWt74jlzOHYanfVjs0WGQt9PGDmR
 F0NzUHs27Jyrr7t2xX9a83g4tO7M12VdvFBMH7Ppu8iv2C3fNCjrcqhJz/bC6ksEAUaU
 nDCb+/NrYCQd52yDDoXyCHdXSHknwjih2572T0L4zpwcgHcHgr6WG7LvcP0A9tD4ao5V
 n1o8KEtUPpM2fkZkellH/cjNoZBBeVcxGN9S8BhLrIHTJbui6StBLJ65s6e9zh5EWO/V
 oUIQ==
X-Gm-Message-State: AOJu0YyyeZdxD/7VWXrjs0/Q6hkH1yz2dW/Ac451P47acdAw/eD3ZLXK
 BR0JHfdbC8CudkGroEoLJOoAhco0DOrOInY+BsTG6cKx3OUuNFcz7mykDVJH1WtjBWicSZmx9vZ
 XmlD9VOcI4s+mI80=
X-Received: by 2002:a05:6512:3706:b0:503:367c:49c7 with SMTP id
 z6-20020a056512370600b00503367c49c7mr19264595lfr.53.1697187348936; 
 Fri, 13 Oct 2023 01:55:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy03vTntIlTa9xle41QUsZt+Th/voGHHQI41Pp5jkfIDRzbg5Wa2GaEyVGUMMfi/THtlWOsg==
X-Received: by 2002:a05:6512:3706:b0:503:367c:49c7 with SMTP id
 z6-20020a056512370600b00503367c49c7mr19264580lfr.53.1697187348608; 
 Fri, 13 Oct 2023 01:55:48 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 k22-20020a05600c0b5600b0040588d85b3asm1931229wmr.15.2023.10.13.01.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:55:47 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [RFC PATCH v2 75/78] migration: add fallthrough pseudo-keyword
In-Reply-To: <0576767d85b1b990a65f7b9cc922a50d9855ea57.1697183699.git.manos.pitsidianakis@linaro.org>
 (Emmanouil Pitsidianakis's message of "Fri, 13 Oct 2023 10:57:42
 +0300")
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
 <0576767d85b1b990a65f7b9cc922a50d9855ea57.1697183699.git.manos.pitsidianakis@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 13 Oct 2023 10:55:46 +0200
Message-ID: <87ttqu6gvh.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>

To make things easier for everybody involved, I think it is better than
this patch goes through your tree.

I didn't know about this C language feature.  Find it very useful.

Thanks, Juan.


