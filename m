Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D13E7FDA47
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 15:48:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Lqg-0003fx-B9; Wed, 29 Nov 2023 09:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8Lqd-0003fl-Id
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 09:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8Lqc-0005rZ-4D
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 09:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701269248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ltjrbMpvkgQqF98C+Y7x8N8RL3MfM0dQqeG0GkmfScI=;
 b=R1ZyLtG+i/ptb7wdJxsqstRwyNvmb1Kz+pbPeuAIPuAnqXk/nQgmMuu4aOSkwZGEywlEI2
 bAUQcSdLcRA7J8I99kWP44EKUfIiE2wG7jamFXrvSxXPp7uxYWaYxO2Y09kIM0c6xTSCim
 TEeZH7c3ZzUobv4RJivVek1yMUtZS+s=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-W7zdDD70OuykaEiT9ViIzw-1; Wed, 29 Nov 2023 09:47:27 -0500
X-MC-Unique: W7zdDD70OuykaEiT9ViIzw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5addc394a4cso19720257b3.1
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 06:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701269246; x=1701874046;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ltjrbMpvkgQqF98C+Y7x8N8RL3MfM0dQqeG0GkmfScI=;
 b=BjqKD3CXko/4QGZS3QfLMvXAe9dmu2A3P2WhIXm115C6SIOK9Vqd8Yloe2odi7PyGC
 Oe2vkR1cSs8UBThXrnCcDiLOwt/0KrEBx0iTwjd8rfctfdErbaDNFMEimU4b95KeeGGF
 yuR7+ZejtVnNrzKwbYNybTevycwOd9/jMk/hLARC3Wmkbqz2QwWieQw+YjNdo8HYACBL
 kwHmanlqOC88hNK8WRopZc1enRdeMgSSir9t38DnEGmzKf5m/LDMr5QlJf/xwyA1ZBZf
 /XbecaKj4pThZLEO8ZpD9TkJbSO5f7ZUt0n4MTW3ihXkFlMIEdD80bUJUHI6W9WIbFj6
 a/Tw==
X-Gm-Message-State: AOJu0Yw9YC8Xph8Ylz0I+hcluI1XGLut+OoCJsicsjsbizl3l/ueutKE
 oN1M68fwDTYQSPNTOLs77ynIfl3NRuvkDVhEo3mWjcWBt11RZpJtp7Sz61nQRpLwIUnnVpLsfjW
 /Nm4ehDY4QhjfL5w=
X-Received: by 2002:a0d:d64a:0:b0:5cc:87d0:7b64 with SMTP id
 y71-20020a0dd64a000000b005cc87d07b64mr12947148ywd.3.1701269246678; 
 Wed, 29 Nov 2023 06:47:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK49GzjCs8cK+BhkJOgt6+0Wf4mf8Ltr0isVNaDZSmTr7GOhvkMRMYhPxoMqdPKOAtDwelFw==
X-Received: by 2002:a0d:d64a:0:b0:5cc:87d0:7b64 with SMTP id
 y71-20020a0dd64a000000b005cc87d07b64mr12947132ywd.3.1701269246362; 
 Wed, 29 Nov 2023 06:47:26 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 qz19-20020a05620a8c1300b0077dc5e60fa1sm1101712qkn.54.2023.11.29.06.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 06:47:26 -0800 (PST)
Date: Wed, 29 Nov 2023 09:47:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Zongmin Zhou <zhouzongmin@kylinos.cn>, Juan Quintela <quintela@redhat.com>
Cc: berrange@redhat.com, farosas@suse.de, leobras@redhat.com,
 qemu-devel@nongnu.org, quintela@redhat.com
Subject: Re: [PATCH v3] migration: free 'saddr' since be no longer used
Message-ID: <ZWdO_C51ckWT0bdK@x1n>
References: <ZVdw_XMJ4mKMFejd@x1n>
 <20231120031428.908295-1-zhouzongmin@kylinos.cn>
 <ZVtmn0WXTKPxCbKU@x1n>
 <7b1c8be9-788a-4cf1-aa6a-ad8f718d7118@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b1c8be9-788a-4cf1-aa6a-ad8f718d7118@kylinos.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Nov 29, 2023 at 10:09:12AM +0800, Zongmin Zhou wrote:
> Ping? Has this been forgotten?

Juan,

Would you send a pull to include this?

Thanks!

-- 
Peter Xu


