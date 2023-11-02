Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C1B7DEFF5
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:29:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUwE-0005rw-2d; Thu, 02 Nov 2023 06:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyUwC-0005rj-9K
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyUwA-0004vb-OD
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698920908;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dOZgaCnURxqNzsB278HbV5c8SmK48FS5lnpnZuuky3A=;
 b=Sf30WfWuzGJqmXqy+GeKCLjA4pP+OlNZo7eGOWJSp0tA/6Itw9XsP3DT5fuAbT4oj8vAxq
 PFVDeVJrkMVEh8mVwCgDeAEMpZs2a8T1G373qiJHwGegECp7ictcnmjN3vbeDy/Y3S7UWZ
 vx7XXEUCI5G+01XRdF7g0HooLNjMmqs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-o7BPgtF0N6uMH4hDIPX1Sw-1; Thu, 02 Nov 2023 06:28:26 -0400
X-MC-Unique: o7BPgtF0N6uMH4hDIPX1Sw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32f5b22e806so350252f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698920905; x=1699525705;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dOZgaCnURxqNzsB278HbV5c8SmK48FS5lnpnZuuky3A=;
 b=ou3iHTOaflErooSZWYAoyP3tmhvwgJWngbe8eewaPdB6amGVBJDkwRbqNvL0lz6L7I
 lNh/sFOuKYsOLak8ovMQ6XFrsdweG7dkUPMKT0boEPwkr6r2PVtHqh1PrLzIi2vTifh9
 bbxE0YD857Jeo5qX074JhLOL/LZk4qDvutn3ybP34x2nSnHAk4C/m2Cjs99uxE5bHrBt
 GYqxYxl/uHENmqBVGOGtgcEm18qnJcvqP/FwHZqWlTO/uSk07McjF24sSfwJkXYQmLbI
 r9TzH5nVwwSzGCzL0w/MFABpAsFR42xaRC5uihRYGAzzu8LVVw2Xu8wfMaqtPrWyGsxO
 V+pg==
X-Gm-Message-State: AOJu0Yx4U+Bcr+J/UIiB0b234ax9PXIlhLWuCardC6S0J0TCT5s+yy7m
 YDCEpEEBuI6YxEf+rlbV6uKydPAkvpKEYjWZxvpnYdXFLTYEwPBSTUwY3lbRmZh0dqupfyrADKq
 HrfhK7DCx0KfUW3U=
X-Received: by 2002:adf:fac2:0:b0:32d:b411:4667 with SMTP id
 a2-20020adffac2000000b0032db4114667mr13062679wrs.30.1698920905696; 
 Thu, 02 Nov 2023 03:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk5s4Zt2qUOJplRWaxYygHFKidLmGEy5uQVyh5yYtme4VcYSHGQhhplb5IbhXotLnGl0oClA==
X-Received: by 2002:adf:fac2:0:b0:32d:b411:4667 with SMTP id
 a2-20020adffac2000000b0032db4114667mr13062663wrs.30.1698920905367; 
 Thu, 02 Nov 2023 03:28:25 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 t8-20020adfe448000000b003197869bcd7sm2056087wrm.13.2023.11.02.03.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:28:24 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [v3 1/6] system/dirtylimit: Fix a race situation
In-Reply-To: <27c86239e21eda03d11ce5a3d07da3c229f562e3.1698847223.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Wed, 1 Nov 2023 22:04:04 +0800")
References: <cover.1698847223.git.yong.huang@smartx.com>
 <27c86239e21eda03d11ce5a3d07da3c229f562e3.1698847223.git.yong.huang@smartx.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 02 Nov 2023 11:28:24 +0100
Message-ID: <87y1fg30vr.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Fix a race situation for global variable dirtylimit_state.
>
> Also, replace usleep by g_usleep to increase platform
> accessibility to the sleep function.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Message-Id: <f25558b3d94083ce6909da5b5cfb922ae5935626.1697815117.git.yong.huang@smartx.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


