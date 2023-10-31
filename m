Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7CC7DD480
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 18:19:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxsNC-0002mW-Pl; Tue, 31 Oct 2023 13:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxsN4-0002mG-Of
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxsN3-0004xb-A6
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698772659;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0QqjB289v5LDe9mjKdn/aUwJDuxMdXqWPquQslr4Szk=;
 b=XbJ1WecO0zGGnpR1kbOLjR0Lq+L5SdStP7Kk1XCnXE7xW5yrS695JlrUqb+D8KsbkWLdOB
 8SM6yT406F45K0lSks2mgM5czmZCod+BEP/7JBP2HcDzNw+2vKxXikeV0cmZrq2KPNre1D
 Qle4TbozELjit40ZSbzFAquADv/aUSA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-5-tc0YaRMAGg-ZE9noGoWA-1; Tue, 31 Oct 2023 13:17:37 -0400
X-MC-Unique: 5-tc0YaRMAGg-ZE9noGoWA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32cef5f8af5so15765f8f.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 10:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698772656; x=1699377456;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0QqjB289v5LDe9mjKdn/aUwJDuxMdXqWPquQslr4Szk=;
 b=T7WVKLzCJ3cG8NkdgTZutkRq/u5wTjUerD4s7wGNuK0P0h7gtPD9L45txeVfPcyurY
 izVyJpAevqXIHGd4QXf+a2FYdk1g9CAL5t9uwYOaxy0fx5FaxbCC2nTdyNVSieNgHMsD
 VnM6C/WKEYqMZqjFkqjbPUaV3Ys39RqUUpvklvdNYy8JFpkKZQdz49s5Wsw40fApJkLJ
 PkQEqkFfZjXqy+2Q+3TmlCUKXbTgGsLnBJnMdRLgXr9JXS7fG8QuK4c11SeJPXX2gRtU
 nU5Foynu6rDLRd1JVdokw7eVrTX4ApF40WUBKEOnAw8HSzTTVzo6jglWZil0hkQ1oIMZ
 A+7A==
X-Gm-Message-State: AOJu0YwLmcLyQmPqOPv7JJek7/hlpYZbZhOsI7lYUidyxL0vXv8WOQw0
 cllVJUDyxyEY90M/0gWcj/J+1yiXhvTGzZ1+ZEP7pkowNMJxu+mhXec9k1Zy45VIUNSrdQh9f17
 Sd076Or7w82yiQkk=
X-Received: by 2002:adf:db0a:0:b0:32f:81f6:9a1e with SMTP id
 s10-20020adfdb0a000000b0032f81f69a1emr2846691wri.28.1698772655899; 
 Tue, 31 Oct 2023 10:17:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQf6ID0JNogRl+cjsOldd3IS84cqauJyI1XTAIy7Jf63cwxQrJ3xQ74WP6B8FigjMuuPsMUw==
X-Received: by 2002:adf:db0a:0:b0:32f:81f6:9a1e with SMTP id
 s10-20020adfdb0a000000b0032f81f69a1emr2846662wri.28.1698772655515; 
 Tue, 31 Oct 2023 10:17:35 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l12-20020adffe8c000000b0030647449730sm1938374wrr.74.2023.10.31.10.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:17:34 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 10/14] fixup! migration: New migrate and
 migrate-incoming argument 'channels'
In-Reply-To: <20231023182053.8711-11-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:49 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-11-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 18:17:34 +0100
Message-ID: <8734xq679t.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


