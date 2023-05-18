Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB09707E49
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:41:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzb3X-0002xh-J2; Thu, 18 May 2023 06:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzb3V-0002xZ-ER
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzb3T-0000i4-Tp
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684406419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BtIArZQBJx/kyyQPWJ03XIcDZhMlmNQKWbbpCfER1w8=;
 b=dL7aWvbgZK60g0zYGClBtuuWw254Uk8VsjwaYKYGRuzQgQxc5ys5tbk93raDEfTms9OWle
 SRPZkd9Tveh0mwT7W7hBr9H4PohkxIq83cGN+Ulff33/mPyYFFxHf0iZztQUT0qkqMoi29
 oD1ozzvNYWk/pDNdfwOTO9VzrBGpRVk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-flFAkibIPVaXKXgYPu4bgQ-1; Thu, 18 May 2023 06:40:17 -0400
X-MC-Unique: flFAkibIPVaXKXgYPu4bgQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so1369735e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684406416; x=1686998416;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BtIArZQBJx/kyyQPWJ03XIcDZhMlmNQKWbbpCfER1w8=;
 b=Y1sa7wxjYbgF6o5y9vxzIey0LKESLqpx3RYxUxMO2ZgJ2BcWFwZFupe/1+pQIjxLK0
 em8GjpqMwWv/jWXLwFfZIYuH43ha2kJ/3J5OpZCrqv261Z8l/n6O5lbtdWwgFRg4Ngaw
 d8namFnzM0gI/QBeAhb/TZpG1ZPuA7OumXEusGBFrz5O+xAbZ+6/WMSiD6Fo3WaoCrEV
 i+fF88QBx6UddJv6fJ7y3dYFbZZv/mwN3C9aBD5b3sLeA4ADPh6eaKsz2ww64AbLQsDK
 w0gGk2pV++6ajNFCmAZej3IxiqVp5rZZHxeE+oue0tpAzI7tvG3jpYJmrjxwjo6nRhei
 zWUw==
X-Gm-Message-State: AC+VfDwdqLLO7wUEYaQRUOOzOOcgGCcbQspunwbjbla5l8miRdKxiobM
 Ca4WjbyqpKIC3niqEmI6KeSY1Z1eInVXN76LusYoFcWYlNvlIFy17pmpwIrQ0HSNiKVLn7JECf5
 oMs8C/9fu352hMM0=
X-Received: by 2002:a1c:7703:0:b0:3f4:e4cd:f6e with SMTP id
 t3-20020a1c7703000000b003f4e4cd0f6emr958907wmi.17.1684406416440; 
 Thu, 18 May 2023 03:40:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4nikudvg+AzK/CWf/55bgihRE8f5HQk+8+2OCibxrZUbgrnKz7RHvicUqO7mVrZqs9RYBn3A==
X-Received: by 2002:a1c:7703:0:b0:3f4:e4cd:f6e with SMTP id
 t3-20020a1c7703000000b003f4e4cd0f6emr958895wmi.17.1684406416122; 
 Thu, 18 May 2023 03:40:16 -0700 (PDT)
Received: from redhat.com ([2.52.6.43]) by smtp.gmail.com with ESMTPSA id
 z4-20020a05600c220400b003f4069417absm4890004wml.24.2023.05.18.03.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:40:15 -0700 (PDT)
Date: Thu, 18 May 2023 06:40:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
Message-ID: <20230518063559-mutt-send-email-mst@kernel.org>
References: <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com>
 <87zg63m18g.fsf@linaro.org>
 <20230517112347-mutt-send-email-mst@kernel.org>
 <87r0rflzd4.fsf@linaro.org>
 <20230517120710-mutt-send-email-mst@kernel.org>
 <87ilcqnckm.fsf@linaro.org>
 <C2CC04A8-F0F1-4360-ABF0-1F8DF7768AB1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C2CC04A8-F0F1-4360-ABF0-1F8DF7768AB1@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, May 18, 2023 at 11:31:47AM +0530, Ani Sinha wrote:
> 
> 
> > On 17-May-2023, at 9:50 PM, Alex Bennée <alex.bennee@linaro.org> wrote:
> > 
> > ./tests/bios-tables-test --iasl-path ${CONFIG_IASL}
> > 
> > and then you have the best of both worlds. You can run manually with a
> > different path and you don't need to pollute config-host.h
> 
> It could also be an environment variable set by meson. Then bios-tables-test can do a genenv() just like it does for verbosity etc. The environment can also be used by other tools that might need iasl in the future. We do not need to introduce new command line option.

The annoying thing with both these approaches is they work
less well than current code since iasl won't be invoked
at all if you do not remember the magic variable to set
or flag to pass. ATM it is self-contained.

Can we split this variable out to config-test.h maybe?
Then you can reconfigure with a different iasl and QEMU
will not be rebuilt, just the tests.


-- 
MST


