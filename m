Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 734AB7CE0F9
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:18:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8Hu-0005OR-F4; Wed, 18 Oct 2023 11:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1qt8Hs-0005Nf-Fd
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:16:44 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1qt8Hq-0008TQ-Kw
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:16:44 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3226cc3e324so6213262f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1697642200; x=1698247000; darn=nongnu.org;
 h=content-transfer-encoding:content-language:mime-version:user-agent
 :date:message-id:cc:subject:from:to:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DExL8xTBIeVwgqkt5P2msyuVyJabWD53OfdkNH0aH7E=;
 b=W/rxaB1nQ+yEnk7z7haIKEFXtvBJAeZ1r4mUkbHRmJ0HOZhmzDVMXQWwmr0gp9YJsP
 JZh0iBQTRYTycZ2GfMfIGXLmtqIfmhkb3KyKT8rYvOCWeeEn3Z9jmm5ziP4RKnyiWxQW
 hVS78yDtiCxZ3TgkYDOvUETCoO0254JkTYrhw0dxbIrD6ti42FC7xhfr0DFxL8TKSaQP
 0UkFM+rwi0fn3lJEigpHZFWRl+Y/xX5XoVkh66g3vFDbcukjQtxsihjARjciqM8n+UKy
 oZvM5VWOnHpPAUbA7Oqsn1rKhKGnNn93bKEDr6+XrkVyH1AQEwQ6lJ23GaGgJQRt31Mc
 ZLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697642200; x=1698247000;
 h=content-transfer-encoding:content-language:mime-version:user-agent
 :date:message-id:cc:subject:from:to:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DExL8xTBIeVwgqkt5P2msyuVyJabWD53OfdkNH0aH7E=;
 b=kamvyRI0mG7zUdTq2Ek4OqBKghV34UCX6PxVz4gFOqjhfAEo6dBFl0Y/tVzYJkMYSI
 jW3fC5PgQ/Aj/HYpaHSSL6XYqyXj4Ze0m/86dhXG6P0NMG99J1NCNVx7O6VASZNS3T7b
 uTP9+CXfzWnGpdDIHHjwRZ5yOamC70Luw8LeHZwNuEZ7Zkn7CX/FmQDFxop407JAvou8
 ylktC1Py3ESmnNLICFq6vMRNCVCTVZYj5DFKm8fD1p4ZjdHkpWLMMZTxRyDYDGxi+FeQ
 oQJ7OPSin235kIHQmrzJ05i6oRt3q/Ee3VzyrsSgO3ejbjyFTD1Hyn8xPbdyace+ohcg
 v8/Q==
X-Gm-Message-State: AOJu0YycGB8JjzJDMtCLJmtBoLQ2XjUSVka6HZdo73Ay4vCxfoIDTX8F
 Dm5mGI+XBW8ZbBBWSL81LCITMA==
X-Google-Smtp-Source: AGHT+IHq36s1rn0eLwa29Fkh8dYepyZmJVmtnDMF8A6JBJ9p7sxYOaO/CultxqrVby+wXmxMMxY2ZA==
X-Received: by 2002:adf:fa47:0:b0:319:67ac:4191 with SMTP id
 y7-20020adffa47000000b0031967ac4191mr4226851wrr.37.1697642200432; 
 Wed, 18 Oct 2023 08:16:40 -0700 (PDT)
Received: from [10.8.0.13] ([185.223.232.243])
 by smtp.gmail.com with ESMTPSA id
 q13-20020adff78d000000b00326dd5486dcsm2321285wrp.107.2023.10.18.08.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 08:16:40 -0700 (PDT)
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Salil Mehta <salil.mehta@opnsrc.net>
Subject: [Question] x86/microvm: why has_hotpluggable_cpus = false but
 hot(ub)plug APIs exist?
Cc: "mst@redhat.com" <mst@redhat.com>,
 "imammedo@redhat.com >> Igor Mammedov" <imammedo@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "david@redhat.com >> David Hildenbrand" <david@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>
Message-ID: <78103368-9ea5-167b-5700-7d3d174ff564@opnsrc.net>
Date: Wed, 18 Oct 2023 16:16:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

Came across below code excerpt in x86/microvm code and wanted to know 
why 'has_hotpluggable_cpus' flag has been set to 'false' while various 
hot(un)plug APIs have been defined?

static void microvm_class_init(ObjectClass *oc, void *data)
{
     X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);

     mc->init = microvm_machine_state_init;

     mc->family = "microvm_i386";
     [...]
     mc->max_cpus = 288;
     mc->has_hotpluggable_cpus = false;  --------> This one
     [...]

     /* hotplug (for cpu coldplug) */
     mc->get_hotplug_handler = microvm_get_hotplug_handler;
     hc->pre_plug = microvm_device_pre_plug_cb;
     hc->plug = microvm_device_plug_cb;
     hc->unplug_request = microvm_device_unplug_request_cb;
     hc->unplug = microvm_device_unplug_cb;
     [...]
}


Best regards
Salil

