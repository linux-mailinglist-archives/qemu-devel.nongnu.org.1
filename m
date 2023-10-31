Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFDA7DD4B1
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 18:30:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxsYG-0005dn-5Q; Tue, 31 Oct 2023 13:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxsYD-0005db-VD
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxsYC-0006cg-FB
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698773351;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NJVrT0PGlutheNfjs3YtKs6pMtdYlFoLx0Z2IRuH6N0=;
 b=iImsgHubpKiQyeUGewXp9k61OpFZTSxFhKeHIeuqFjAScE41wsBaIUXe1Pwjoa4aWr/KSq
 WhHgqUZxWViX3CHPn4a+D7YkgyxSppdD9brQfoGeOHWsdOgGPlgvwKJ9gjvLsrpT5Bwhvi
 VsZ4jChLpWvK87RorIRPxSkJjGL+g1I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-OJPVXJP_M1i3arbEFZELFg-1; Tue, 31 Oct 2023 13:29:09 -0400
X-MC-Unique: OJPVXJP_M1i3arbEFZELFg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32d9602824dso2998273f8f.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 10:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698773348; x=1699378148;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJVrT0PGlutheNfjs3YtKs6pMtdYlFoLx0Z2IRuH6N0=;
 b=cp9XxcfPYMBotrsPsjTG5N+p/UFQJWHDGrQZtqNR0KrW0JXcbwYBIxXpeouU2I2raS
 Ln65BugFiegsZGX/zGScdvK84IpAIZ4q5k53UNKHPetvduP5A4obIcEhR0qIVC5ZmXJv
 NrxvN8UuTgcY84gCAzlWB0mtCDf+k6LjqukRKIfVyiRogtfGenazryntJBtkl7eqAww2
 ggXyPbLD7VsNnahXee4ZoSN4ONG6rUBCSpRWBzINnxBj26GbtdLidKzFZnTUqxI4rCUG
 0gL7Y8Z8CGSyNQLDf30K78TAWuChI+DeT4jt9OkoEPK77DIm87ECgbk7wWaU3+cqBorD
 wUsg==
X-Gm-Message-State: AOJu0YxF6O02gYSgl1ry2MsBytbSWGO992hdJiTnx6Tep/AWpjdnEUTZ
 5Ei+5Ji2KOd9ST5MrNEZfT/4dQY2/fEfw1kE/TIEJaoin8Eqw7R9Jqwr3yAKOVGzqOu+/Pg1eey
 kUL8i+xBGvaOzEZg=
X-Received: by 2002:a05:6000:1372:b0:31f:a0ab:26b5 with SMTP id
 q18-20020a056000137200b0031fa0ab26b5mr11271271wrz.8.1698773348378; 
 Tue, 31 Oct 2023 10:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzvT9YAY1Gwq+8b+lJfW0usYNHWHwy/usMapIhBVkvHlRn2L5QA0L16HGGp97Li4adCZRBjQ==
X-Received: by 2002:a05:6000:1372:b0:31f:a0ab:26b5 with SMTP id
 q18-20020a056000137200b0031fa0ab26b5mr11271253wrz.8.1698773348045; 
 Tue, 31 Oct 2023 10:29:08 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l10-20020a5d4bca000000b003143867d2ebsm1963519wrt.63.2023.10.31.10.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:29:07 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v15 14/14] migration: modify test_multifd_tcp_none() to
 use new QAPI syntax.
In-Reply-To: <20231023182053.8711-15-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:53 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-15-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 18:29:06 +0100
Message-ID: <87ttq64s65.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

Fabiano Rosas <farosas@suse.de> wrote:
> From: Het Gala <het.gala@nutanix.com>
>
> modify multifd tcp common test to incorporate the new QAPI
> syntax defined.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


