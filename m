Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA837DEFF4
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:29:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUwQ-0005sd-D8; Thu, 02 Nov 2023 06:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyUwO-0005sT-9h
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyUwM-0004xg-AU
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698920921;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1B4hBKwFvt6AmpXDWQjq/PjPW8RCL+c3vzhwL3fxSQY=;
 b=aVGOvZ7S6bfZ92cZYQ7gMUF73tyRtFoKNcjokzskqeiBdv1eOBup1P7WlzYIj3koKhjKn+
 dygZ2rjtchJ9I9hGlRt+G5LROoXnhnFy8Mr7nkreie44Lr3LW+Wn0poVTAXIk0D4tC9cRf
 2W53zyOs9Zqv1ENHaeQ1Gm2aM5Xbrz8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-hptRgfUsMjGW0R1Z9Fhy1w-1; Thu, 02 Nov 2023 06:28:39 -0400
X-MC-Unique: hptRgfUsMjGW0R1Z9Fhy1w-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c53c85e482so8406711fa.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698920918; x=1699525718;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1B4hBKwFvt6AmpXDWQjq/PjPW8RCL+c3vzhwL3fxSQY=;
 b=NrX0pimv6pu9ufnHXft572/7i+HbtkJbH+Fzg51cvlJfb9ubpwRiBuMLHT6oRlC9Jg
 NfPSE9u1WSV8jKR0gPQviEJvGzJQo+hlNk43sg1AUmGUEKtFEMsNYK1Q0pENhVLZe+fN
 KQb4bAP+hJAvk9+WI4Q53foWiplsI+pZpcybX37aztzRdJrikQvWiFBrJcnKDRgSxA1l
 cjf/j/sokvto1F4P0LN+WDolDocpCo5+VBTQ+yAmrA0PGLaBA9g5D6uQOTrTrprNeyM9
 +SpIL3r9umKXwOO9qLphLy5L1u/GS0ndCRexnQvX5FgWp9x62qJcd5ZIouHAy2Ch4b7S
 XCtQ==
X-Gm-Message-State: AOJu0YzvGGtTflriUuvI5Dvhc4Ua4FyLpSRO4Zq2fQ0goSVNh5cMCAql
 yzNUsD4TTBBy81vFXKb2qBTTdPOreIxhHP4y5ddFYoOMCz60zcB5MwkzLm4D/JX7cLdvI4xqvNe
 nqeWANBw9qrkJPvQ=
X-Received: by 2002:a2e:9044:0:b0:2bc:c771:5498 with SMTP id
 n4-20020a2e9044000000b002bcc7715498mr16388367ljg.18.1698920918210; 
 Thu, 02 Nov 2023 03:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx0LuOtrsd0s84v9P1PAR9N/QXkOH1QjeT9MEJFy9TSRBmLx0E1nfiENpsO1UOqDPntYGKnQ==
X-Received: by 2002:a2e:9044:0:b0:2bc:c771:5498 with SMTP id
 n4-20020a2e9044000000b002bcc7715498mr16388351ljg.18.1698920917886; 
 Thu, 02 Nov 2023 03:28:37 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 h10-20020a05600c350a00b0040775fd5bf9sm2446665wmq.0.2023.11.02.03.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:28:37 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [v3 2/6] system/dirtylimit: Drop the reduplicative check
In-Reply-To: <df9c3514933ff6750ef88068af18d3054bedf746.1698847223.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Wed, 1 Nov 2023 22:04:05 +0800")
References: <cover.1698847223.git.yong.huang@smartx.com>
 <df9c3514933ff6750ef88068af18d3054bedf746.1698847223.git.yong.huang@smartx.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 02 Nov 2023 11:28:36 +0100
Message-ID: <87ttq430vf.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hyman Huang <yong.huang@smartx.com> wrote:
> Checking if dirty limit is in service is done by the
> dirtylimit_query_all function, drop the reduplicative
> check in the qmp_query_vcpu_dirty_limit function.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Message-Id: <31384f768279027560ab952ebc2bbff1ddb62531.1697815117.git.yong.huang@smartx.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
queued.


