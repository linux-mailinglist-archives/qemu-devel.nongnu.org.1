Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B067DCFEA
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:13:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqPx-0005Wi-KM; Tue, 31 Oct 2023 11:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxqPu-0005WX-2X
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxqPs-0007HB-Og
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698765148;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2RekfC+nb55ZBRy+00AdZfPFmtdwS52OeMj0i+nMCs=;
 b=IaL+V21jVclw3qJdbEllrba8xhg/FKtmiiM2I1XRwl76HNRg/2/YR6OH8wN3IotWSgJbxk
 /M/7ALzavi0Crmb1ggr53s5NbHj6FsY3/Yx/HpWlt7i4mIRM9ew/V2F+zaOpQ0skHiHwaL
 BfG5VuNWwVAo0d9hMvLhM1X2ENWldUU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-GdqFPPo1OdmmcvLuQ84b2A-1; Tue, 31 Oct 2023 11:12:16 -0400
X-MC-Unique: GdqFPPo1OdmmcvLuQ84b2A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-407f9d07b41so42963695e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698765136; x=1699369936;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y2RekfC+nb55ZBRy+00AdZfPFmtdwS52OeMj0i+nMCs=;
 b=GZl64HYFbSXBfBCp7qAPKVtfkbE4e7yg/WiFYkau7TXN6N0oAmVXYqSZv9G2ZwcadK
 MCGGJJUq1I+0VTHAef+20RCvNFMf3O2eCuyuimxiS7I/EBI1xktmZ5C8EixaD376CuZi
 yW/aPKNxaZ9ssXAU83faxT2Am89vvPnyJsP7/vXAtHzeKWzWaj6PxVoMXlm384oXRiDh
 w2HpBc2C2NS4b5ZyBHizkZ2Kt7b4+DZgTma23rQwkuhr6FTi+by51qxQwiYD1ns0y0Hz
 NCkUgsAMkK0bhWlwDxf7TxMUrxamV6pITNTCWKyZVm0aQILqOjgL2Im8nsJQyhhvPyAq
 sJiQ==
X-Gm-Message-State: AOJu0Yx6v88ebxmPXWk3y4Bzpg7+9rOPhnojG61/Q1eL6CYpIF1o/6Hf
 V1T/Ph1fZu9/7xpdA7AoG8rN1sJcWlErabJbqmCcD2ZJ54CELGTNp6STNNQxPievhZjl5zECJ6h
 iqhvwd6+PreL0LV0=
X-Received: by 2002:a05:600c:4f0f:b0:401:d803:624f with SMTP id
 l15-20020a05600c4f0f00b00401d803624fmr10569604wmq.4.1698765135787; 
 Tue, 31 Oct 2023 08:12:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFDK+kzRjzj9XFhjaGV3H6j8iJJ6IyW2KxWPLjxg9wedx/yB57j7y0tFA6gTRRBBi7thQ0cQ==
X-Received: by 2002:a05:600c:4f0f:b0:401:d803:624f with SMTP id
 l15-20020a05600c4f0f00b00401d803624fmr10569577wmq.4.1698765135419; 
 Tue, 31 Oct 2023 08:12:15 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 d8-20020a05600c3ac800b00401d8181f8bsm1999995wms.25.2023.10.31.08.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 08:12:14 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 05/14] migration: convert socket backend to accept
 MigrateAddress
In-Reply-To: <20231023182053.8711-6-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:44 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-6-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 16:12:14 +0100
Message-ID: <87o7ge6d2p.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

Fabiano Rosas <farosas@suse.de> wrote:
> From: Het Gala <het.gala@nutanix.com>
>
> Socket transport backend for 'migrate'/'migrate-incoming' QAPIs accept
> new wire protocol of MigrateAddress struct.
>
> It is achived by parsing 'uri' string and storing migration parameters
> required for socket connection into well defined SocketAddress struct.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


