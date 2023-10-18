Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82DA7CDAF7
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:49:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt527-00021T-Dy; Wed, 18 Oct 2023 07:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt525-00021B-ED
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt522-0000ZH-RZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697629689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wFXmxYD46AGERYybnfGUKh3kMpG4WvXCr8YY/ec3+jc=;
 b=U2lasw13YTE0jxewwdNBGboxNsTC39aEBak0t3GGVR/v/1ksDAT1fsbQxdb5/OgA/+caXi
 avwIxo7fjwPCSPjI43m9HvsV4JkCX7Bl19aKSg+CxgYpeSuh/aOQO7niNA+NunPr8I5U9G
 ovl+vVzJsyRtFt7pNEfOATThRZq+uk0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-Qpzg2qRWMsGrICghucDP4Q-1; Wed, 18 Oct 2023 07:47:57 -0400
X-MC-Unique: Qpzg2qRWMsGrICghucDP4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D4AE1C0BB5C
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:47:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 445208C1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:47:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37E6621E6A1F; Wed, 18 Oct 2023 13:47:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Andrea Bolognani
 <abologna@redhat.com>
Subject: Re: [PATCH v2 11/11] docs: add notes on Golang code generator
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-12-victortoso@redhat.com>
Date: Wed, 18 Oct 2023 13:47:56 +0200
In-Reply-To: <20231016152704.221611-12-victortoso@redhat.com> (Victor Toso's
 message of "Mon, 16 Oct 2023 17:27:04 +0200")
Message-ID: <87mswgqhhv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Victor Toso <victortoso@redhat.com> writes:

> The goal of this patch is converge discussions into a documentation,
> to make it easy and explicit design decisions, known issues and what
> else might help a person interested in how the Go module is generated.
>
> Signed-off-by: Victor Toso <victortoso@redhat.com>
> ---
>  docs/devel/index-build.rst          |   1 +
>  docs/devel/qapi-golang-code-gen.rst | 376 ++++++++++++++++++++++++++++
>  2 files changed, 377 insertions(+)
>  create mode 100644 docs/devel/qapi-golang-code-gen.rst
>
> diff --git a/docs/devel/index-build.rst b/docs/devel/index-build.rst
> index 57e8d39d98..8f7c6f5dc7 100644
> --- a/docs/devel/index-build.rst
> +++ b/docs/devel/index-build.rst
> @@ -15,5 +15,6 @@ the basics if you are adding new files and targets to the build.
>     qtest
>     ci
>     qapi-code-gen
> +   qapi-golang-code-gen
>     fuzzing
>     control-flow-integrity

Let's not worry whether and how this should be integrated with
qapi-code-gen.rst for now.

I'm a Go ignoramus.  I hope my comments are at least somewhat helpful
all the same.

> diff --git a/docs/devel/qapi-golang-code-gen.rst b/docs/devel/qapi-golang-code-gen.rst
> new file mode 100644
> index 0000000000..b62daf3bad
> --- /dev/null
> +++ b/docs/devel/qapi-golang-code-gen.rst
> @@ -0,0 +1,376 @@
> +==========================
> +QAPI Golang code generator
> +==========================
> +
> +..
> +   Copyright (C) 2023 Red Hat, Inc.
> +
> +   This work is licensed under the terms of the GNU GPL, version 2 or
> +   later.  See the COPYING file in the top-level directory.
> +
> +
> +Introduction
> +============
> +
> +This document provides information of how the generated Go code maps
> +with the QAPI specification, clarifying design decisions when needed.
> +
> +
> +Scope of the generated Go code
> +==============================

What do you mean by "scope"?

> +
> +The scope is limited to data structures that can interpret and be used
> +to generate valid QMP messages. These data structures are generated
> +from a QAPI schema and should be able to handle QMP messages from the
> +same schema.
> +
> +The generated Go code is a Go module with data structs that uses Go
> +standard library ``encoding/json``, implementing its field tags and
> +Marshal interface whenever needed.
> +
> +
> +QAPI types to Go structs
> +========================
> +
> +Enum
> +----
> +
> +Enums are mapped as strings in Go, using a specified string type per
> +Enum to help with type safety in the Go application.
> +
> +::
> +
> +    { 'enum': 'HostMemPolicy',
> +      'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
> +
> +.. code-block:: go
> +
> +    type HostMemPolicy string
> +
> +    const (
> +        HostMemPolicyDefault    HostMemPolicy = "default"
> +        HostMemPolicyPreferred  HostMemPolicy = "preferred"
> +        HostMemPolicyBind       HostMemPolicy = "bind"
> +        HostMemPolicyInterleave HostMemPolicy = "interleave"
> +    )
> +
> +
> +Struct
> +------
> +
> +The mapping between a QAPI struct in Go struct is very straightforward.
> + - Each member of the QAPI struct has its own field in a Go struct.
> + - Optional members are pointers type with 'omitempty' field tag set
> +
> +One important design decision was to _not_ embed base struct, copying
> +the base members to the original struct. This reduces the complexity
> +for the Go application.
> +
> +::
> +
> +    { 'struct': 'BlockExportOptionsNbdBase',
> +      'data': { '*name': 'str', '*description': 'str' } }
> +
> +    { 'struct': 'BlockExportOptionsNbd',
> +      'base': 'BlockExportOptionsNbdBase',
> +      'data': { '*bitmaps': ['BlockDirtyBitmapOrStr'],
> +                '*allocation-depth': 'bool' } }
> +
> +.. code-block:: go
> +
> +    type BlockExportOptionsNbd struct {
> +        Name        *string `json:"name,omitempty"`
> +        Description *string `json:"description,omitempty"`
> +
> +        Bitmaps         []BlockDirtyBitmapOrStr `json:"bitmaps,omitempty"`
> +        AllocationDepth *bool                   `json:"allocation-depth,omitempty"`
> +    }

Is there a need to convert from type to base type?

In C, we get away with (BlockExportOptionsNbdBase *)obj.  We hide it in
an inline function, though.

> +
> +
> +Union
> +-----
> +
> +Unions in QAPI are binded to a Enum type which provides all possible

bound to an Enum

> +branches of the union. The most important caveat here is that the Union
> +does not need to have a complex type implemented for all possible
> +branches of the Enum. Receiving a enum value of a unimplemented branch

I'd call that branch empty, not unimplemented.

> +is valid.
> +
> +For this reason, the generated Go struct will define a field for each
> +Enum value. The Go type defined for unbranched Enum values is bool

Important design decision: since Go sucks at sum types, you elect to add
all the variant members to the struct.  Only one of them may be used at
any time.  Please spell that out more clearly.

> +
> +Go struct and also implement the Marshal interface.

Blank line in the middle of a sentence?  Or two sentences?  Can't make
sense of them.

What do you mean by "unbranched" Enum value?  Enum value with an
implicit (empty) branch?

> +
> +As each Union Go struct type has both the discriminator field and
> +optional fields, it is important to note that when converting Go struct
> +to JSON, we only consider the discriminator field if no optional field
> +member was set. In practice, the user should use the optional fields if
> +the QAPI Union type has defined them, otherwise the user can set the
> +discriminator field for the unbranched enum value.

I don't think I get this paragraph.

> +
> +::
> +
> +    { 'union': 'ImageInfoSpecificQCow2Encryption',
> +      'base': 'ImageInfoSpecificQCow2EncryptionBase',
> +      'discriminator': 'format',
> +      'data': { 'luks': 'QCryptoBlockInfoLUKS' } }

The example is hard to understand without additional context, namely:

       { 'struct': 'ImageInfoSpecificQCow2EncryptionBase',
         'data': { 'format': 'BlockdevQcow2EncryptionFormat'}}

       { 'enum': 'BlockdevQcow2EncryptionFormat',
         'data': [ 'aes', 'luks' ] }

> +
> +.. code-block:: go
> +
> +    type ImageInfoSpecificQCow2Encryption struct {
> +        // Variants fields
> +        Luks *QCryptoBlockInfoLUKS `json:"-"`
> +        // Unbranched enum fields
> +        Aes bool `json:"-"`
> +    }

The members of the base type are the common members, and the members of
the branch's type are the variant members.

Your example shows the variant member: 'luks'.

The common member @format isn't there.  I guess you're eliding it
because you can derive its value from other members.

If there were other common members, where would they go?

> +
> +    func (s ImageInfoSpecificQCow2Encryption) MarshalJSON() ([]byte, error) {
> +        // ...
> +        // Logic for branched Enum
> +        if s.Luks != nil && err == nil {
> +            if len(bytes) != 0 {
> +                err = errors.New(`multiple variant fields set`)
> +            } else if err = unwrapToMap(m, s.Luks); err == nil {
> +                m["format"] = BlockdevQcow2EncryptionFormatLuks
> +                bytes, err = json.Marshal(m)
> +            }
> +        }
> +
> +        // Logic for unbranched Enum
> +        if s.Aes && err == nil {
> +            if len(bytes) != 0 {
> +                err = errors.New(`multiple variant fields set`)
> +            } else {
> +                m["format"] = BlockdevQcow2EncryptionFormatAes
> +                bytes, err = json.Marshal(m)
> +            }
> +        }
> +
> +        // ...
> +        // Handle errors
> +    }
> +
> +
> +    func (s *ImageInfoSpecificQCow2Encryption) UnmarshalJSON(data []byte) error {
> +        // ...
> +
> +        switch tmp.Format {
> +        case BlockdevQcow2EncryptionFormatLuks:
> +            s.Luks = new(QCryptoBlockInfoLUKS)
> +            if err := json.Unmarshal(data, s.Luks); err != nil {
> +                s.Luks = nil
> +                return err
> +            }
> +        case BlockdevQcow2EncryptionFormatAes:
> +            s.Aes = true
> +
> +        default:
> +            return fmt.Errorf("error: unmarshal: ImageInfoSpecificQCow2Encryption: received unrecognized value: '%s'",
> +                tmp.Format)
> +        }
> +        return nil
> +    }
> +
> +
> +Alternate
> +---------
> +
> +Like Unions, alternates can have a few branches. Unlike Unions, they

Scratch "a few".

> +don't have a discriminator field and each branch should be a different
> +class of Type entirely (e.g: You can't have two branches of type int in
> +one Alternate).
> +
> +While the marshalling is similar to Unions, the unmarshalling uses a
> +try-and-error approach, trying to fit the data payload in one of the
> +Alternate fields.
> +
> +The biggest caveat is handling Alternates that can take JSON Null as
> +value. The issue lies on ``encoding/json`` library limitation where
> +unmarshalling JSON Null data to a Go struct which has the 'omitempty'
> +field that, it bypass the Marshal interface. The same happens when
> +marshalling, if the field tag 'omitempty' is used, a nil pointer would
> +never be translated to null JSON value.
> +
> +The problem being, we use pointer to type plus ``omitempty`` field to
> +express a QAPI optional member.
> +
> +In order to handle JSON Null, the generator needs to do the following:
> +  - Read the QAPI schema prior to generate any code and cache
> +    all alternate types that can take JSON Null
> +  - For all Go structs that should be considered optional and they type
> +    are one of those alternates, do not set ``omitempty`` and implement
> +    Marshal interface for this Go struct, to properly handle JSON Null
> +  - In the Alternate, uses a boolean 'IsNull' to express a JSON Null
> +    and implement the AbsentAlternate interface, to help sturcts know

Typo: to help structs

> +    if a given Alternate type should be considered Absent (not set) or
> +    any other possible Value, including JSON Null.
> +
> +::
> +
> +    { 'alternate': 'BlockdevRefOrNull',
> +      'data': { 'definition': 'BlockdevOptions',
> +                'reference': 'str',
> +                'null': 'null' } }
> +
> +.. code-block:: go
> +
> +    type BlockdevRefOrNull struct {
> +        Definition *BlockdevOptions
> +        Reference  *string
> +        IsNull     bool
> +    }
> +
> +    func (s *BlockdevRefOrNull) ToAnyOrAbsent() (any, bool) {
> +        if s != nil {
> +            if s.IsNull {
> +                return nil, false
> +            } else if s.Definition != nil {
> +                return *s.Definition, false
> +            } else if s.Reference != nil {
> +                return *s.Reference, false
> +            }
> +        }
> +
> +        return nil, true
> +    }
> +
> +    func (s BlockdevRefOrNull) MarshalJSON() ([]byte, error) {
> +        if s.IsNull {
> +            return []byte("null"), nil
> +        } else if s.Definition != nil {
> +            return json.Marshal(s.Definition)
> +        } else if s.Reference != nil {
> +            return json.Marshal(s.Reference)
> +        }
> +        return []byte("{}"), nil
> +    }
> +
> +    func (s *BlockdevRefOrNull) UnmarshalJSON(data []byte) error {
> +        // Check for json-null first
> +        if string(data) == "null" {
> +            s.IsNull = true
> +            return nil
> +        }
> +        // Check for BlockdevOptions
> +        {
> +            s.Definition = new(BlockdevOptions)
> +            if err := StrictDecode(s.Definition, data); err == nil {
> +                return nil
> +            }
> +            s.Definition = nil
> +        }
> +        // Check for string
> +        {
> +            s.Reference = new(string)
> +            if err := StrictDecode(s.Reference, data); err == nil {
> +                return nil
> +            }
> +            s.Reference = nil
> +        }
> +
> +        return fmt.Errorf("Can't convert to BlockdevRefOrNull: %s", string(data))
> +    }
> +
> +
> +Event
> +-----
> +
> +All events are mapped to its own struct with the additional

Each event is mapped to its own

> +MessageTimestamp field, for the over-the-wire 'timestamp' value.
> +
> +Marshaling and Unmarshaling happens over the Event interface, so users
> +should use the MarshalEvent() and UnmarshalEvent() methods.
> +
> +::
> +
> +    { 'event': 'SHUTDOWN',
> +      'data': { 'guest': 'bool',
> +                'reason': 'ShutdownCause' } }
> +
> +.. code-block:: go
> +
> +    type Event interface {
> +        GetName() string
> +        GetTimestamp() Timestamp
> +    }
> +
> +    type ShutdownEvent struct {
> +        MessageTimestamp Timestamp     `json:"-"`
> +        Guest            bool          `json:"guest"`
> +        Reason           ShutdownCause `json:"reason"`
> +    }
> +
> +    func (s *ShutdownEvent) GetName() string {
> +        return "SHUTDOWN"
> +    }
> +
> +    func (s *ShutdownEvent) GetTimestamp() Timestamp {
> +        return s.MessageTimestamp
> +    }
> +
> +
> +Command
> +-------
> +
> +All commands are mapped to its own struct with the additional MessageId

Each command is mapped to its own

> +field for the optional 'id'. If the command has a boxed data struct,
> +the option struct will be embed in the command struct.
> +
> +As commands do require a return value, every command has its own return
> +type. The Command interface has a GetReturnType() method that returns a
> +CommandReturn interface, to help Go application handling the data.
> +
> +Marshaling and Unmarshaling happens over the Command interface, so
> +users should use the MarshalCommand() and UnmarshalCommand() methods.
> +
> +::
> +
> +   { 'command': 'set_password',
> +     'boxed': true,
> +     'data': 'SetPasswordOptions' }

Since you show the Go type generated for QAPI type SetPasswordOptions,
you should show the QAPI type here.

> +
> +.. code-block:: go
> +
> +    type Command interface {
> +        GetId() string
> +        GetName() string
> +        GetReturnType() CommandReturn
> +    }
> +
> +    // SetPasswordOptions is embed
> +    type SetPasswordCommand struct {
> +        SetPasswordOptions
> +        MessageId string `json:"-"`
> +    }
> +
> +    // This is an union
> +    type SetPasswordOptions struct {
> +        Protocol  DisplayProtocol    `json:"protocol"`
> +        Password  string             `json:"password"`
> +        Connected *SetPasswordAction `json:"connected,omitempty"`
> +
> +        // Variants fields
> +        Vnc *SetPasswordOptionsVnc `json:"-"`
> +    }
> +
> +Now an example of a command without boxed type.
> +
> +::
> +
> +    { 'command': 'set_link',
> +      'data': {'name': 'str', 'up': 'bool'} }
> +
> +.. code-block:: go
> +
> +    type SetLinkCommand struct {
> +        MessageId string `json:"-"`
> +        Name      string `json:"name"`
> +        Up        bool   `json:"up"`
> +    }
> +
> +Known issues
> +============
> +
> +- Type names might not follow proper Go convention. Andrea suggested an
> +  annotation to the QAPI schema that could solve it.
> +  https://lists.gnu.org/archive/html/qemu-devel/2022-05/msg00127.html


